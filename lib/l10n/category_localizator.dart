import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/categories_repository.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';

//TODO? add localization of start categories
class CategoryLocalizator {
  void updateEmptyCategoryTitle(AppLocalizations localizations) {
    var emptyCategory = Category.emptyCategory();
    emptyCategory.title = localizations.noCategory;
    var repository = CategoriesRepository();
    repository.insertCategory(emptyCategory);
  }
}