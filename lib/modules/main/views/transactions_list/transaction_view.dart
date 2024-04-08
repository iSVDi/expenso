import 'package:expenso/common/views/date_time_picker.dart';
import 'package:expenso/common/views/enter_text_bottom_sheet.dart';
import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';
import 'package:expenso/common/views/select_categories_list/select_categories_list.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:expenso/my_app.dart';
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
  //? need use Repository Provider
  final _repository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(context), appBar: _getAppBar(context));
  }

  ColorScheme _getColorScheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  PreferredSizeWidget _getAppBar(BuildContext context) {
    return AppBar(actions: [_getDeleteBarButton(context)]);
  }

//? need present confirmation alert
  IconButton _getDeleteBarButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          _repository.deleteTransaction(transaction);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.black,
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
    var titleColor = _getColorScheme(context).onBackground;
    var title = Text(
      "${transaction.date.formattedDate}, ${transaction.date.formattedTime}",
      style: Theme.of(context).textTheme.appTitle3.copyWith(color: titleColor),
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
    var textColor = _getColorScheme(context).primary;
    var title = transaction.category.target!.title;
    var text = Text(
      title,
      style: Theme.of(context)
          .textTheme
          .appTitle1
          .copyWith(color: textColor, fontWeight: FontWeight.w300),
    );
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
      contentFunc: selectCategoriesList,
    );
    return textButton;
  }

// todo move text to special class
  Widget _getCommentButton() {
    var textColor = _getColorScheme(context).primary;
    var comment =
        transaction.comment.isEmpty ? "add Comment" : transaction.comment;
    var text = Text(
      comment,
      style: Theme.of(context).textTheme.appBody.copyWith(color: textColor),
    );
    var enterCommentSheet = EnterTextBottomSheet(
        hintText: "add Comment",
        callback: (comment) => _updateComment(comment));

    var textButton =
        _getPresentModallyButton(child: text, content: enterCommentSheet);
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

    // var text = Text(transaction.stringAmount,
    //     style: const TextStyle(
    //       fontSize: 50,
    //       fontWeight: FontWeight.w300,
    //       color: Colors.black,
    //     ));
    var text = Text(
      transaction.stringAmount,
      style: Theme.of(context)
          .textTheme
          .appLargeTitle
          .copyWith(color: _getColorScheme(context).onBackground),
    );
    var textButton = _getPresentModallyButton(
      child: text,
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

  void _updateCategory(Category category) {
    setState(() {
      transaction.category.target = category;
      _repository.insertTransaction(transaction);
    });
  }

  TextButton _getPresentModallyButton(
      {required Widget child,
      Function(BuildContext context)? contentFunc,
      Widget? content}) {
    var textButton = TextButton(
        child: child,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (buildContext) => content ?? contentFunc!(buildContext)));
    return textButton;
  }
}
