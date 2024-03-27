// ignore_for_file: file_names
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list.dart';
import 'package:expenso/extensions/app_colors.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

import 'package:expenso/modules/main/views/enter_transaction_data/request_comment_sheet.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';

import '../../cubits/keyboard/keyboard_cubit.dart';
import '../../cubits/keyboard/keyboard_states.dart';

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

class EnterTransactionData extends StatelessWidget {
  final Size size;

  const EnterTransactionData({
    Key? key,
    required this.size,
  }) : super(key: key);

  KeyboardCubit _getCubit(BuildContext context) {
    return context.read<KeyboardCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocBuilder<KeyboardCubit, KeyboardState>(
      builder: (context, state) {
        return SizedBox(
            height: size.height,
            width: size.width,
            child: _getKeyboard(context));
      },
    );
    return bloc;
  }

  Widget _getKeyboard(BuildContext context) {
    var cubit = _getCubit(context);
    Widget keyboard;

    if (cubit.state is EnteringBasicDataState) {
      keyboard = SizedNumericKeyboard.sizedKeyboard(context, cubit.getAmount,
          dateTime: cubit.getDate, (amount, dateTime) {
        cubit.setAmount(amount);
        if (dateTime != null) {
          cubit.setDate(dateTime);
        }
        doneButtonHandler(context);
      });
    } else {
      keyboard = SelectCategoriesList(backButtonCallback: () {
        cubit.backCategoriesButtonHandler();
      }, doneButtonCallback: (category) {
        cubit.setCategory(category);
        doneButtonHandler(context);
      });
    }
    return ColoredBox(
        color: AppColors.appNumericKeyboardColor, child: keyboard);
  }

  void doneButtonHandler(BuildContext context) {
    var cubit = _getCubit(context);
    if (cubit.state is SelectingCategoriesState) {
      _showCommentSheet(context);
    }
    cubit.doneButtonHandler();
  }

  void _showCommentSheet(BuildContext context) {
    var enterCommentSheet = EnterTextBottomSheet(
        // todo move to special class
        hintText: "добавить комментарий",
        callback: (String comment) {
          _getCubit(context).updateComment(comment);
        });

    var askCommentSheet = RequestCommentSheet(callback: (needEnterComment) {
      if (needEnterComment) {
        _showSheet(context, enterCommentSheet);
      } else {
        _getCubit(context).setEmptyComment();
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
