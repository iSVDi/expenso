import 'package:expenso/common/views/date_time_picker.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:flutter/material.dart';

import 'package:expenso/common/data_layer/models/transaction.dart';

class TransactionView extends StatefulWidget {
  final Transaction transaction;

  const TransactionView({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionViewState();
}

class TransactionViewState extends State<TransactionView> {
  Transaction get transaction => widget.transaction;
  final _repository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(context), appBar: _getAppBar(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(actions: [_getDeleteBarButton(context)]);
  }

  IconButton _getDeleteBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _repository.deleteTransaction(transaction);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.delete,
          color: AppColors.appBlack,
        ));
  }

  Widget _getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getDateButton(),
          _getCategoryButton(),
          _getCommentButton(),
          _getAmountButton()
        ],
      ),
    );
    // return ;
  }

  Widget _getDateButton() {
    var title = Text(
      "${transaction.date.formattedDate}, ${transaction.date.formattedTime}",
      // TODO use textTheme
      style: const TextStyle(
        fontWeight: FontWeight.w100,
        fontSize: 24,
        color: AppColors.appBlack,
      ),
    );
    var dateTimePicker = DateTimePicker(
      selectedDate: transaction.date,
      callback: (date) {
        _updateDate(date);
        Navigator.of(context).pop();
      },
    );
    var textButton = TextButton(
      child: title,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => dateTimePicker);
      },
    );
    return textButton;
  }

  Widget _getCategoryButton() {
    var title = transaction.category.target!.title;
    // TODO use textTheme
    var text = Text(title,
        style: const TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 40,
            color: AppColors.appGreen));

    selectCategoriesList(BuildContext builderContext) {
      return SelectCategoriesList(
        isManagingCategories: false,
        selectedCategory: transaction.category.target!,
        doneButtonCallback: (category) {
          _updateCategory(category);
          Navigator.pop(builderContext);
        },
        backButtonCallback: () {
          Navigator.pop(builderContext);
        },
        categoryUpdatedCallback: (category) {
          _updateCategory(category);
        },
      );
    }

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => selectCategoriesList(context),
    );
    return textButton;
  }

// TODO move text to special class
  Widget _getCommentButton() {
    var comment =
        transaction.comment.isEmpty ? "add Comment" : transaction.comment;
    var text = Text(comment,
        //TODO use textTheme
        style: const TextStyle(
            fontWeight: FontWeight.w100,
            fontSize: 20,
            color: AppColors.appGreen));
    enterTextBottomSheet(BuildContext builderContext) {
      return EnterTextBottomSheet(
          hintText: "add Comment",
          bottomInsets: MediaQuery.of(context).viewInsets.bottom,
          callback: (comment) => _updateComment(comment));
    }

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => enterTextBottomSheet(context),
    );
    return textButton;
  }

  Widget _getAmountButton() {
    keyboard(BuildContext buildContext) {
      return SizedNumericKeyboard.sizedKeyboard(
        context: context,
        amount: transaction.stringAmount,
        doneButtonCallback: (amountString, dateTime) {
          setState(() {
            _updateAmount(amountString);
            Navigator.pop(buildContext);
          });
        },
      );
    }

    var text = Text(transaction.stringAmount,
        //TODO use textTheme
        style: const TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w300,
          color: AppColors.appBlack,
        ));

    var textButton = _getPresentModallyButton(
      child: text,
      builder: (context) => keyboard(context),
    );
    return textButton;
  }

  void _updateDate(DateTime? date) {
    if (date != null) {
      setState(() {
        transaction.date = date;
        _repository.insertTransaction(transaction);
      });
    }
  }

  void _updateComment(String comment) {
    setState(() {
      transaction.comment = comment;
      _repository.insertTransaction(transaction);
    });
  }

  void _updateAmount(String amountString) {
    setState(() {
      transaction.amount = double.parse(amountString);
      _repository.insertTransaction(transaction);
    });
  }

  void _updateCategory(Category category) {
    setState(() {
      transaction.category.target = category;
      _repository.insertTransaction(transaction);
    });
  }

  TextButton _getPresentModallyButton(
      {required Widget child, required Widget Function(BuildContext) builder}) {
    var textButton = TextButton(
        child: child,
        onPressed: () =>
            showModalBottomSheet(context: context, builder: builder));
    return textButton;
  }
}
