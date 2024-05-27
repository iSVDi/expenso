import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/gen/objectbox/objectbox.g.dart';
import 'package:expenso/main.dart';

class CategoriesRepository {
  final Box<Category> _categories =
      objectBoxStoreKeeper.getObjectBoxStore.box<Category>();

  void insertCategory(Category category) {
    _categories.put(category);
  }

  void insertCategories(List<Category> categories) {
    _categories.putMany(categories);
  }

  List<Category> readAllCategories() {
    return _categories
        .query()
        .order(Category_.id, flags: Order.descending)
        .build()
        .find()
        .toList();
  }

  void deleteCategory(Category category) {
    _categories.remove(category.id);
  }
}
