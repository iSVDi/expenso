import 'dart:ui';

import 'package:expenso/common/data_layer/models/category.dart';

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
