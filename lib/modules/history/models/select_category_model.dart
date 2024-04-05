import 'dart:ui';

import 'package:expenso/common/data_layer/models/category.dart';

// TODO add data for selecting categories buttons
class SelectCategoryModel {
  Category category;
  double value;
  Color color;

  SelectCategoryModel({
    required this.category,
    required this.value,
    required this.color,
  });
}
