// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/views/dateTimePicker.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getBody(), appBar: _getAppBar());
  }

  PreferredSizeWidget _getAppBar() {
    return AppBar(actions: []);
  }

  Widget _getBody() {
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

    return TextButton(
        child: title,
        onPressed: () {
          //Todo implement
          // print("edit date button pressed");
          showDialog(
              context: context,
              builder: (BuildContext context) => DateTimePicker(
                    selectedDate: transaction.date,
                    callback: (date) {
                      if (date != null) {
                        setState(() {
                          transaction.date = date;
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ));
        });
    // return
  }

  Widget _getCategoryButton() {
    var title = Text(transaction.category.target?.title ?? "no category");
    return TextButton(
        child: title,
        onPressed: () {
          //Todo implement
          print("edit category button pressed");
        });
  }

  Widget _getCommentButton() {
    var comment =
        transaction.comment.isEmpty ? "add Comment" : transaction.comment;
    var title = Text(comment);
    return TextButton(
        child: title,
        onPressed: () {
          //Todo implement
          print("edit comment button pressed");
        });
  }

  Widget _getAmountButton() {
    var title = Text(transaction.amount.toString());
    return TextButton(
        child: title,
        onPressed: () {
          //Todo implement
          print("edit amount button pressed");
        });
  }
}
