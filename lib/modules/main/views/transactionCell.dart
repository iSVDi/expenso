// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:expenso/extensions/appColors.dart';

// TODO implement ID
class Category {
  final Icon icon;
  final String title;

  Category({
    required this.icon,
    required this.title,
  });

// TODO remove
  static Category getStamp() {
    return Category(
        icon: const Icon(Icons.medication_outlined), title: "medicine");
  }
}

// TODO implement ID
class Transaction {
  final DateTime date;
  final String comment;
  final Category category;
  final double amount;

  Transaction({
    required this.date,
    required this.comment,
    required this.category,
    required this.amount,
  });

// TODO remove
  static List<Transaction> getStampList() {
    List<Transaction> list = [];

    for (var i = 0; i < 10; i++) {
      list.add(Transaction(
          date: DateTime.now(),
          comment: "cardio pills",
          category: Category.getStamp(),
          amount: 250));
    }

    return list;
  }
}

class TransactionCell extends StatelessWidget {
  final Transaction transaction;

  const TransactionCell({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getCell();
  }

  Row _getCell() {
    var priceLabel = _getLabel(transaction.amount.toString(), Colors.black, 24);
    var transactionContainer = Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Row(children: [
         transaction.category.icon,
         _getLabel(transaction.category.title, AppColors.appGreen, 18)
        ]),
        _getLabel(transaction.comment, AppColors.appGreen, 12)
      ]),
    );
    return Row(children: [priceLabel, transactionContainer]);
  }


  Text _getLabel(String title, Color titleColor, double fontSize) {
    return Text(title, style: TextStyle(fontSize: fontSize, color: titleColor));
  }
}
