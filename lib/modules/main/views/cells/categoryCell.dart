import "package:expenso/modules/main/models/category.dart";
import "package:flutter/material.dart";

class CategoryCell extends StatelessWidget {
  final bool needSetBold;
  final Category category;
  const CategoryCell(
      {Key? key, required this.needSetBold, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontWeight = needSetBold ? FontWeight.bold : FontWeight.normal;
    var text = Text(
      category.title,
      style: TextStyle(fontWeight: fontWeight),
    );
    return text;
  }
}
