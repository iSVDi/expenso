import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:expenso/modules/main/models/category.dart';

typedef dbNames = _KeyboardRepositoryNames;

class _KeyboardRepositoryNames {
  static const String _databaseName = "eXpenso.db";
  static const String _categoriesTableName = "categories";
  static const String _idColumnName = "id";
  static const String _titleColumnName = "title";
}

//TODO add defalut categories
class KeyboardRepository {
  late Database _database;
  bool _isDatabaseOpened = false;

  Future<String> get fullPath async {
    final path = await getDatabasesPath();
    return join(path, dbNames._databaseName);
  }

  Future _openIfNeed() async {
    if (!_isDatabaseOpened) {
      final path = await fullPath;
      _database = await openDatabase(path, version: 1, onCreate: _create);
      _isDatabaseOpened = true;
    }
  }

  Future<Category> insert(Category category) async {
    await _openIfNeed();
    var codeResult =
        await _database.insert(dbNames._categoriesTableName, category.toMap());
    if (codeResult == 0) {
      throw Error();
    }
    var newMapCategory = await _database.query(dbNames._categoriesTableName,
        orderBy: "${dbNames._idColumnName} DESC", limit: 1);
    var categories = [
      for (final {
            dbNames._idColumnName: id as int,
            dbNames._titleColumnName: title as String
          } in newMapCategory)
        Category(id: id, title: title)
    ];
    return categories.first;
  }

  Future<List<Category>> getCategories() async {
    await _openIfNeed();
    final List<Map<String, Object?>> categoriesMap = await _database.query(
        dbNames._categoriesTableName,
        orderBy: "${dbNames._idColumnName} DESC");
    var categories = [
      for (final {
            dbNames._idColumnName: id as int,
            dbNames._titleColumnName: title as String
          } in categoriesMap)
        Category(id: id, title: title)
    ];
    return categories;
  }

  Future<void> _create(Database db, int version) async {
    await db.execute('''
create table if not exists ${dbNames._categoriesTableName} (
    ${dbNames._idColumnName} integer primary key autoincrement,
    ${dbNames._titleColumnName} text not null)
    ''');
  }
}
