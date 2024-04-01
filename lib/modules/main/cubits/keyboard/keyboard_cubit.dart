import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import '../../../../common/data_layer/models/category.dart';
import '../../../../common/data_layer/repositories/categories_repository.dart';
import 'keyboard_states.dart';

class KeyboardCubit extends Cubit<KeyboardState> {
  Transaction _transaction = Transaction.empty(date: DateTime.now());

  String get getAmount => _transaction.stringAmount;
  DateTime get getDate => _transaction.date;
  Category get getCategory => _transaction.category.target!;

  final _categoriesRepository = CategoriesRepository();
  final _transactionRepository = TransactionRepository();

  KeyboardCubit() : super(EnteringBasicDataState());

// *  Interface
  void doneButtonHandler() {
    if (state is EnteringBasicDataState) {
      _saveAmount();
    } else if (state is SelectingCategoriesState) {
      _saveTransaction();
    }
  }

  void setDate(DateTime newDate) {
    _transaction.date = newDate;
  }

  void setAmount(String newAmount) {
    _transaction.amount = double.parse(newAmount);
  }

  void setCategory(Category category) {
    _transaction.category.target = category;
  }

  void updateComment(String comment) {
    _transactionRepository.updateLastTransactionsComment(comment);
    emit(EnteringBasicDataState());
  }

  void backCategoriesButtonHandler() {
    emit(EnteringBasicDataState());
  }

  void addNewCategory(String title) {
    Category category = Category(title: title);
    _categoriesRepository.insertCategory(category);
    setCategory(category);
    emit(SelectingCategoriesState());
  }

  List<Category> getCategories() {
    return _categoriesRepository.readAllCategories();
  }

  void _saveAmount() {
    emit(SelectingCategoriesState());
  }

  void _saveTransaction() {
    _transactionRepository.insertTransaction(_transaction);
    _transaction = Transaction.empty(date: DateTime.now());
    emit(EnteringBasicDataState());
  }
}
