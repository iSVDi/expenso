// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/views/dateTimePicker.dart';
import 'package:expenso/common/views/enterTextBottomSheet.dart';
import 'package:expenso/common/views/numericKeyboard/numericKeyboard.dart';
import 'package:expenso/common/views/selectCategoriesList.dart';
import 'package:expenso/modules/main/dataLayer/models/category.dart';
import 'package:expenso/modules/main/dataLayer/repositories/categoriesRepository.dart';
import 'package:flutter/material.dart';

import 'package:expenso/modules/main/dataLayer/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionView extends StatefulWidget {
  final Transaction transaction;

  TransactionView({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionViewState();
}

class TransactionViewState extends State<TransactionView> {
  Transaction get transaction => widget.transaction;

  CategoriesRepository _getRepository(BuildContext context) {
    return context.read<CategoriesRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(context), appBar: _getAppBar());
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(actions: []);
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
    var title = Text(transaction.date.toString());
    var dateTimePicker = DateTimePicker(
      selectedDate: transaction.date,
      callback: (date) {
        if (date != null) {
          setState(() {
            transaction.date = date;
          });
        }
        Navigator.of(context).pop();
      },
    );
    var textButton = TextButton(
        child: title,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => dateTimePicker);
        });
    return textButton;
    // return
  }

  Widget _getCategoryButton() {
    // todo move text to special class
    var title = transaction.category.target?.title ?? "no category";
    // var title = Text(transaction.category.target?.title ?? "no category");
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

    var textButton = a(title, contentFunc: selectCategoriesList);
    return textButton;
  }

  Widget _getCommentButton() {
    var comment =
        transaction.comment.isEmpty ? "add Comment" : transaction.comment;
    var enterCommentSheet = EnterTextBottomSheet(
        hintText: "add Comment",
        callback: (comment) {
          setState(() {
            transaction.comment = comment;
          });
        });

    var textButton = a(comment, content: enterCommentSheet);
    return textButton;
  }

  Widget _getAmountButton() {
    keyboard(BuildContext buildContext) {
      return SizedNumericKeyboard.sizedKeyboard(
          context, transaction.stringAmount, (amountString, date) {
        setState(() {
          transaction.amount = double.parse(amountString);
          Navigator.pop(buildContext);
        });
      });
    }

    var textButton = a(transaction.stringAmount, contentFunc: keyboard);
    return textButton;
  }

  void _addNewCategory(BuildContext context, String categoryTitle) {
    var category = Category(title: categoryTitle);
    _getRepository(context).insertCategory(category);
  }

  void _updateCategory(Category? category) {
    setState(() {
      transaction.category.target = category;
    });
  }

  TextButton _getPresentModallyButton(String buttonsTitle, Widget content) {
    var text = Text(buttonsTitle);

    var button = TextButton(
        child: text,
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (buildContext) => content);
        });
    return button;
  }

  TextButton a(String buttonsTitle,
      {Function(BuildContext context)? contentFunc, Widget? content}) {
    var text = Text(buttonsTitle);
    var textButton = TextButton(
        child: text,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (buildContext) => content ?? contentFunc!(buildContext)));
    return textButton;
  }
}
