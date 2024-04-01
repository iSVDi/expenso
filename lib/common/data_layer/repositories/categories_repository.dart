import 'package:expenso/common/data_layer/models/category.dart';
import "package:expenso/objectbox.g.dart";
import '../../../main.dart';

class CategoriesRepository {
  static var _noCategoryId = 1;
  final Box<Category> _categories = objectBoxStore.box<Category>();

  CategoriesRepository() {
    if (_categories.isEmpty()) {
      //todo localize
      insertCategory(Category(title: "no category"));
    }
  }

  void insertCategory(Category category) {
    _categories.put(category);
  }

  List<Category> readAllCategories() {
    var query = _categories
        .query()
        .order(Category_.id, flags: Order.descending)
        .build();
    var res = query.find().where((element) => element.id != _noCategoryId).toList();
    return res;
  }
}
