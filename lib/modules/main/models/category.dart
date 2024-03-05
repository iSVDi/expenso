import "package:flutter/material.dart";

// TODO implement ID
class Category {
  final Icon icon;
  final String title;

  Category({
    required this.icon,
    required this.title,
  });

// TODO remove
  static Category getStamp() {
    return Category(
        icon: const Icon(Icons.medication_outlined), title: "medicine");
  }

  static List<Category> getStampList() {
    List<Category> list = [];
    for (var i = 0; i < 20; i++) {
      list.add(Category.getStamp());
    }
    return list;
  }
}