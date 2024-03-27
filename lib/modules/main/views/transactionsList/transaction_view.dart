import 'package:expenso/common/views/date_time_picker.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/extensions/app_images.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/main/dataLayer/models/category.dart';
import 'package:expenso/modules/main/dataLayer/repositories/transactions_repository.dart';
import 'package:flutter/material.dart';

import 'package:expenso/modules/main/dataLayer/models/transaction.dart';

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
  //? need use Repository Provider
  final _repository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(context), appBar: _getAppBar(context));
  }

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(actions: [_getDeleteBarButton(context)]);
  }

//? need present confirmation alert
  IconButton _getDeleteBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _repository.removeTransaction(transaction);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.delete,
          color: AppColors.appBlack,
        ));
  }

  Widget _getBody(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      _getDateButton(),
      _getCategoryButton(),
      _getCommentButton(),
      _getAmountButton()
    ]));
    // return ;
  }

  Widget _getDateButton() {
    var title = Text(
        "${transaction.date.formattedDate} ${transaction.date.formattedTime}");
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
    // todo move text to special class
    var title = transaction.category.target?.title ?? "no category";
    selectCategoriesList(BuildContext builderContext) {
      return SelectCategoriesList(
          selectedCategory: transaction.category.target,
          doneButtonCallback: (category) {
            _updateCategory(category);
            Navigator.pop(builderContext);
          },
          backButtonCallback: () {
            Navigator.pop(builderContext);
          });
    }

    var textButton = _getPresentModallyButton(
      buttonsTitle: title,
      contentFunc: selectCategoriesList,
    );
    return textButton;
  }

  Widget _getCommentButton() {
    var comment =
        transaction.comment.isEmpty ? "add Comment" : transaction.comment;
    var enterCommentSheet = EnterTextBottomSheet(
        hintText: "add Comment",
        callback: (comment) => _updateComment(comment));

    var textButton = _getPresentModallyButton(
        buttonsTitle: comment, content: enterCommentSheet);
    return textButton;
  }

  Widget _getAmountButton() {
    keyboard(BuildContext buildContext) {
      return SizedNumericKeyboard.sizedKeyboard(
          context, transaction.stringAmount, (amountString, date) {
        setState(() {
          _updateAmount(amountString);
          Navigator.pop(buildContext);
        });
      });
    }

    var textButton = _getPresentModallyButton(
      buttonsTitle: transaction.stringAmount,
      contentFunc: keyboard,
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

  void _updateCategory(Category? category) {
    setState(() {
      transaction.category.target = category;
      _repository.insertTransaction(transaction);
    });
  }

  TextButton _getPresentModallyButton(
      {required String buttonsTitle,
      Function(BuildContext context)? contentFunc,
      Widget? content}) {
    var text = Text(buttonsTitle);
    var textButton = TextButton(
        child: text,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (buildContext) => content ?? contentFunc!(buildContext)));
    return textButton;
  }
}
