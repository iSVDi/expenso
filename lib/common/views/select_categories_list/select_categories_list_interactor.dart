// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/repositories/categories_repository.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';

class SelectCategoriesListInteractor {
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  final TransactionRepository _transactionRepository = TransactionRepository();

  final bool _isManagingCategories;
  Category? _selectedCategory;
  final Function() _setState;

  SelectCategoriesListInteractor({
    required bool isManagingCategories,
    required Category? selectedCategory,
    required dynamic Function() setState,
  })  : _setState = setState,
        _selectedCategory = selectedCategory,
        _isManagingCategories = isManagingCategories;

  bool get isFromSettings => _isManagingCategories;
  Category? get selectedCategory => _selectedCategory;
  List<Category> get readAllCategories =>
      _categoriesRepository.readAllCategories();

  void addCategory(String categoryName) {
    var category = Category(title: categoryName);
    _categoriesRepository.insertCategory(category);
    if (_isManagingCategories) {
      _setState();
    } else {
      selectCategory(category);
    }
  }

  void selectCategory(Category category) {
    Category? currentCategory = _selectedCategory;
    Category? newCategory = category;

    if (currentCategory == category) {
      newCategory = null;
    }

    _selectedCategory = newCategory;
    _setState();
  }

  void editCategory({
    required Category category,
    required String newCategoryName,
    Function(Category?)? categoryUpdatedCallback,
  }) {
    category.title = newCategoryName;
    _categoriesRepository.insertCategory(category);
    _transactionRepository.replaceCategories(from: category, to: category);
    if (!_isManagingCategories) {
      _selectedCategory = category;
    }
    if (selectedCategory == category) {
      categoryUpdatedCallback?.call(_selectedCategory);
    }
    _setState();
  }

  void deleteCategory({
    required Category category,
    Function(Category?)? categoryUpdatedCallback,
  }) {
    if (_selectedCategory == category) {
      _selectedCategory = null;
      categoryUpdatedCallback?.call(_selectedCategory);
    }

    _transactionRepository.replaceCategories(
      from: category,
      to: null,
    );

    _categoriesRepository.deleteCategory(category);
    _setState();
  }

  bool isNeedSetBoldCategoryTitle(Category newCategory) {
    var res = newCategory == _selectedCategory;
    return res;
  }
}
