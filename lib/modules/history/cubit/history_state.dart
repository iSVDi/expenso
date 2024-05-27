import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:flutter/material.dart';

enum ChartType { bar, donut }

class HistoryState {
  DateTimeRange dateRange;
  // All transactions for current date range
  List<Transaction> transactions;
  Set<Category?> selectedCategories = {};
  ChartType chartType;

  HistoryState(
      {required this.dateRange,
      required this.transactions,
      required this.selectedCategories,
      required this.chartType});
}
