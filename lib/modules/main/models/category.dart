import "package:flutter/material.dart";

class Category {
  int id;
  String title;

  Category({
    required this.id,
    required this.title,
  });

  Map<String, Object?> toMap() {
    return {"id": id, "title": title};
  }

  @override
  String toString() {
    return "Category{id: $id, title: $title}";
  }

// TODO remove
  static Category getStamp(int id) {
    return Category(id: id, title: "medicine");
  }

  static List<Category> getStampList() {
    List<Category> list = [];
    for (var i = 0; i < 20; i++) {
      list.add(Category.getStamp(i));
    }
    return list;
  }
}
