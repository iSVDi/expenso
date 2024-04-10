import '../../data_layer/models/category.dart';
import "package:flutter/material.dart";

class CategoryCell extends StatelessWidget {
  final bool isSelected;
  final Category category;

  const CategoryCell({
    Key? key,
    required this.isSelected,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;
    var text = Text(
      category.title,
      style: TextStyle(fontWeight: fontWeight),
    );
    return text;
  }
}
