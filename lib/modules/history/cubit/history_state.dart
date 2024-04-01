import 'package:expenso/common/data_layer/models/category.dart';
import 'package:flutter/material.dart';

enum ChartType {
  bar, pie
}

class HistoryState {
  DateTimeRange timeFrame;
  Set<Category?> selectedCategories = {};
  ChartType chartType;

  HistoryState({
    required this.timeFrame,
    required this.selectedCategories,
    required this.chartType
  });
}
