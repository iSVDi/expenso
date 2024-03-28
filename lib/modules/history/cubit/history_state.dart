import 'package:expenso/common/data_layer/models/category.dart';
import 'package:flutter/material.dart';

class HistoryState {
  DateTimeRange timeFrame;
  List<Category> selectedCategories = [];

  HistoryState({
    required this.timeFrame,
    required this.selectedCategories,
  });
}
