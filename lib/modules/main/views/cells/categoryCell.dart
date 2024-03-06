import "package:expenso/modules/main/models/category.dart";
import "package:flutter/material.dart";

class CategoryCell extends StatelessWidget {
  final Category category;
  const CategoryCell({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [Text(category.title)]);
  }
}
