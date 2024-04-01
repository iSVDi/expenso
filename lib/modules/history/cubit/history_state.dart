import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:flutter/material.dart';

enum ChartType { bar, donut }

class HistoryState {
  DateTimeRange timeFrame;
  // All transactions for current time frame
  List<Transaction> transactions;
  Set<Category> selectedCategories = {};
  ChartType chartType;

  HistoryState(
      {required this.timeFrame,
      required this.transactions,
      required this.selectedCategories,
      required this.chartType});
}
