import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/select_category_model.dart';
import 'package:flutter/material.dart';

class ChartModel {
  double sum;
  ChartType chartType;
  DateTimeRange timeFrame;
  List<SelectCategoryModel> chartCategories;
  List<SelectCategoryModel> selectableCategories;

  ChartModel({
    required this.sum,
    required this.chartType,
    required this.timeFrame,
    required this.chartCategories,
    required this.selectableCategories,
  });
}
