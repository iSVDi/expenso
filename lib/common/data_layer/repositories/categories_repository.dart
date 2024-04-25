import 'package:expenso/common/data_layer/models/category.dart';
import "package:expenso/objectbox.g.dart";
import '../../../main.dart';

class CategoriesRepository {
  static const _noCategoryId = 1;
  final Box<Category> _categories =
      objectBoxStoreKeeper.getObjectBoxStore.box<Category>();

  CategoriesRepository() {
    if (_categories.isEmpty()) {
      var emptyCategory = Category.emptyCategory();
      emptyCategory.id = 0;
      insertCategory(emptyCategory);
    }
  }

  void insertCategory(Category category) {
    _categories.put(category);
  }

  void insertCategories(List<Category> categories) {
    _categories.putMany(categories);
  }

  List<Category> readAllCategories() {
    var query = _categories
        .query()
        .order(Category_.id, flags: Order.descending)
        .build();

    var res =
        query.find().where((element) => element.id != _noCategoryId).toList();
    return res;
  }

  void deleteCategory(Category category) {
    _categories.remove(category.id);
  }
}
