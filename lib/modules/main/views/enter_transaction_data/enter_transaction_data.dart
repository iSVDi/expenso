// ignore_for_file: file_names
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list.dart';
import 'package:expenso/extensions/app_colors.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter/material.dart';

import 'package:expenso/modules/main/views/enter_transaction_data/request_comment_sheet.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';

import '../../cubits/keyboard/keyboard_cubit.dart';
import '../../cubits/keyboard/keyboard_states.dart';

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
      keyboard = SizedNumericKeyboard.sizedKeyboard(
        context: context,
        amount: cubit.getAmount,
        dateTime: cubit.getDate,
        doneButtonCallback: (amount, dateTime) {
          cubit.setAmount(amount);
          if (dateTime != null) {
            cubit.setDate(dateTime);
          }
          doneButtonHandler(context);
        },
      );
    } else {
      keyboard = SelectCategoriesList(
        isManagingCategories: false,
        backButtonCallback: () {
          cubit.backCategoriesButtonHandler();
        },
        doneButtonCallback: (category) {
          cubit.setCategory(category);
          doneButtonHandler(context);
        },
        selectedCategory: Category.emptyCategory(),
      );
    }
    var coloredKeyboard = ColoredBox(
      color: AppColors.appNumericKeyboardColor,
      child: keyboard,
    );

    return coloredKeyboard;
  }

  void doneButtonHandler(BuildContext context) {
    var cubit = _getCubit(context);
    if (cubit.state is SelectingCategoriesState) {
      _showCommentSheet(context);
    }
    cubit.doneButtonHandler();
  }

  void _showCommentSheet(BuildContext context) {
    addCommentSheet(BuildContext buildContext) {
      return EnterTextBottomSheet(
          // TODO move to special class
          hintText: "добавить комментарий",
          bottomInsets: MediaQuery.of(buildContext).viewInsets.bottom,
          callback: (String comment) {
            _getCubit(context).updateComment(comment);
          });
    }

    requestCommentSheet() {
      return RequestCommentSheet(callback: (needEnterComment) {
        if (needEnterComment) {
          _showSheetX(
              context: context,
              builder: (buildContext) => addCommentSheet(buildContext));
        }
      });
    }

    _showSheetX(
        context: context, builder: (_) => requestCommentSheet());
  }

  Future _showSheetX({
    required BuildContext context,
    required Widget Function(BuildContext) builder,
  }) async {
    showModalBottomSheet(useSafeArea: true, context: context, builder: builder);
  }
}
