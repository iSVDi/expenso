// ignore_for_file: file_names
import 'package:expenso/common/views/numericKeyboard/numericKeyboard.dart';
import 'package:expenso/common/views/selectCategoriesList.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

import 'package:expenso/modules/main/views/keyboard/commentSheet.dart';
import 'package:expenso/common/views/enterTextBottomSheet.dart';

import '../../cubits/keyboard/keyboardCubit.dart';
import '../../cubits/keyboard/keyboardStates.dart';

enum NumericKeyboardButtonType {
  point("."),
  zero("0"),
  one("1"),
  two("2"),
  three("3"),
  four("4"),
  five("5"),
  six("6"),
  seven("7"),
  eight("8"),
  nine("9"),
  empty(""),
  delete("x");

  final String value;
  const NumericKeyboardButtonType(this.value);
}

class OnScreenKeyboard extends StatelessWidget {
  final Size size;

  const OnScreenKeyboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  KeyboardCubit _getCubit(BuildContext context) {
    return context.read<KeyboardCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var bloc =
        BlocBuilder<KeyboardCubit, KeyboardState>(builder: (context, state) {
      return SizedBox(
          height: size.height, width: size.width, child: _getKeyboard(context));
    });
    return bloc;
  }

  Widget _getKeyboard(BuildContext context) {
    var cubit = _getCubit(context);
    Widget keyboard;

    if (cubit.state is EnteringBasicDataState) {
      keyboard = NumericKeyboard(
          amount: cubit.getAmount,
          dateTime: cubit.getDate,
          doneButtonCallback: (amount, dateTime) {
            cubit.updateAmount(amount);
            if (dateTime != null) {
              cubit.updateDate(dateTime);
            }
            doneButtonHandler(context);
          });
    } else {
      keyboard = SelectCategoriesList(
          categories: cubit.getCategories(),
          selectedCategory: cubit.getCategory,
          addCategoryCallback: (categoryName) {
            cubit.addNewCategory(categoryName);
          },
          backButtonCallback: () {
            cubit.backCategoriesButtonHandler();
          },
          doneButtonCallback: (category) {
            cubit.updateCategory(category);
            doneButtonHandler(context);
          });
    }
    return keyboard;
  }

  void doneButtonHandler(BuildContext context) {
    var cubit = _getCubit(context);
    if (cubit.state is SelectingCategoriesState) {
      _showCommentSheet(context);
    }
    cubit.doneButtonHandler();
  }

// todo need refactor
  void _showCommentSheet(BuildContext context) {
    var enterCommentSheet = EnterTextBottomSheet(
        // todo move to special class
        hintText: "добавить комментарий",
        callback: (String comment) {
          _getCubit(context).updateComment(comment);
        });

    var askCommentSheet =
        CommentSheet(callback: (needEnterComment, sheetsContext) {
      Navigator.pop(sheetsContext);
      if (needEnterComment) {
        _showSheet(context, enterCommentSheet);
      } else {
        _getCubit(context).updateComment("");
      }
    });
    _showSheet(context, askCommentSheet);
  }

  void commentEnteredHandler(BuildContext context, String comment) {}

  Future _showSheet(BuildContext context, Widget child) async {
    var container = Container(
        height: 100,
        margin: const EdgeInsets.only(left: 32, right: 32),
        child: child);
    showModalBottomSheet(context: context, builder: (context) => container);
  }
}
