import "package:flutter/material.dart";
import "category.dart";

// TODO implement ID
class Transaction {
  final DateTime date;
  final String comment;
  final Category? category;
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
          category: Category.getStamp(i),
          amount: 250));
    }

    return list;
  }
}
