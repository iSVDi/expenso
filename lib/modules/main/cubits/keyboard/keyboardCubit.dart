import "package:expenso/modules/main/dataLayer/models/transaction.dart";
import "package:expenso/modules/main/dataLayer/repositories/transactionsRepository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../dataLayer/models/category.dart";
import "../../dataLayer/repositories/categoriesRepository.dart";
import "keyboardStates.dart";

class KeyboardCubit extends Cubit<KeyboardState> {
  Transaction _transaction = Transaction.empty(date: DateTime.now());

  String get getAmount {
    if (_transaction.amount % 1 == 0) {
      return "${_transaction.amount.toInt()}";
    }
    return "${_transaction.amount}";
  }

  DateTime get getDate => _transaction.date;
  Category? get getCategory => _transaction.category.target;

  final _categoriesRepository = CategoriesRepository();
  final _transactionRepository = TransactionRepository();

  KeyboardCubit() : super(EnteringBasicDataState());

// *  Interface
  void doneButtonHandler() {
    if (state is EnteringBasicDataState) {
      _saveAmount();
    } else if (state is SelectingCategoriesState) {
      _saveCategory();
    }
  }

  void updateDate(DateTime newDate) {
    _transaction.date = newDate;
  }

  void updateAmount(String newAmount) {
    _transaction.amount = double.parse(newAmount);
  }

  void updateCategory(Category? category) {
    _transaction.category.target = category;
  }

  void updateComment(String comment) {
    _transaction.comment = comment;
    _saveTransaction();
  }

  void backCategoriesButtonHandler() {
    emit(EnteringBasicDataState());
  }

  void addNewCategory(String title) {
    Category category = Category(title: title);
    _categoriesRepository.insertCategory(category);
    updateCategory(category);
    emit(SelectingCategoriesState());
  }

  List<Category> getCategories() {
    return _categoriesRepository.readAllCategories();
  }

  void _saveAmount() {
    emit(SelectingCategoriesState());
  }

  void _saveCategory() {
    emit(EnteringBasicDataState());
  }

  void _saveTransaction() {
    _transactionRepository.insertTransaction(_transaction);
    _transaction = Transaction.empty(date: DateTime.now());
    emit(EnteringBasicDataState());
  }
}
