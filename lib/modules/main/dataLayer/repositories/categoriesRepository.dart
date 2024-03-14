import 'package:expenso/modules/main/dataLayer/models/category.dart';
import "package:expenso/objectbox.g.dart";
import '../../../../main.dart';
import 'storageCreator.dart';

class CategoriesRepository {
  final Box<Category> _categories = objectBoxStore.box<Category>();

  void insertCategory(Category category) {
    _categories.put(category);
  }

  List<Category> readAllCategories() {
    var query = _categories
        .query()
        .order(Category_.id, flags: Order.descending)
        .build();
    var res = query.find();
    return res;
  }
}
