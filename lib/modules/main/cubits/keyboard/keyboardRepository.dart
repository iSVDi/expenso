// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:expenso/modules/main/models/category.dart';

class KeyboardRepository {
  final String _databaseName = "eXpenso.db";
  final String categoriesTableName = "categories";
  final String idColumnName = "id";
  final String titleColumnName = "title";
  Database? _database;

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, _databaseName);
  }

  Future open() async {
    final path = await fullPath;
    _database = await openDatabase(path, version: 1, onCreate: _create);
  }

  Future<void> _create(Database db, int version) async {
    await db.execute('''
create table $categoriesTableName (
    $idColumnName integer primary key autoincrement,
    $titleColumnName text not null
''');
  }

  Future<Category?> insert(Category category) async {
    if (_database != null) {
      category.id =
          await _database!.insert(categoriesTableName, category.toMap());
      return category;
    }
    return null;
  }

  Future<List<Category>?> getCategories() async {
    if (_database != null) {
      final List<Map<String, Object?>> categoriesMap =
          await _database!.query(categoriesTableName);
      var categories = [
        for (final {"id": id as int, "title": title as String} in categoriesMap)
          Category(id: id, title: title)
      ];
      return categories;
    }
    return null;
  }
}
