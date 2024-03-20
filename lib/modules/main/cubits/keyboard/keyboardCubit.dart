import "package:expenso/modules/main/dataLayer/models/transaction.dart";
import "package:expenso/modules/main/dataLayer/repositories/transactionsRepository.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:expenso/modules/main/views/numericKeyboard/numericKeyboard.dart';
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';
import "../../dataLayer/models/category.dart";
import "../../dataLayer/repositories/categoriesRepository.dart";
import "keyboardStates.dart";

class KeyboardCubit extends Cubit<KeyboardState> {
  final _amountUpdater = AmountStringUpdater();

  // This values used only for keep data
  late double _amount;
  late DateTime _date;
  Category? _selectedCategory;
  String _enteredComment = "";

  String get getAmount => (state as EnteringBasicDataState).data.$1;
  DateTime get getDate => (state as EnteringBasicDataState).data.$2;
  Category? get getCategory => (_selectedCategory);

  final _categoriesRepository = CategoriesRepository();
  final _transactionRepository = TransactionRepository();

  KeyboardCubit()
      : super(EnteringBasicDataState(
            data: (NumericKeyboardButtonType.zero.value, DateTime.now())));

// *  Interface
  void doneButtonHandler() {
    if (state is EnteringBasicDataState) {
      _saveAmount();
    } else if (state is SelectingCategoriesState) {
      _saveCategory();
    }
  }

  void updateDate(DateTime newDate) {
    _date = newDate;
  }

  void updateAmount(String newAmount) {
    _amount = double.parse(newAmount);
  }

  void updateCategory(Category? category) {
    _selectedCategory = category;
  }

  bool isNeedSetBoldCategoryTitle(Category category) {
    var currentState = (state as SelectingCategoriesState).data;
    if (currentState != null) {
      var res = category.id == currentState.id;
      return res;
    }
    return false;
  }

  void saveComment(String comment) {
    _enteredComment = comment;
    _saveTransaction();
  }

  void backCategoriesButtonHandler() {
    var stringAmount = "";
    if (_amount % 1 == 0) {
      // stringAmount
      stringAmount = "${_amount.toInt()}";
    } else {
      stringAmount = "$_amount";
    }

    emit(EnteringBasicDataState(data: (stringAmount, _date)));
  }

  void addNewCategory(String title) async {
    Category category = Category(title: title);
    _categoriesRepository.insertCategory(category);
    updateCategory(category);
    emit(SelectingCategoriesState(data: category));
  }

  List<Category> getCategories() {
    return _categoriesRepository.readAllCategories();
  }

  void _saveAmount() {
    emit(SelectingCategoriesState(data: null));
  }

  void _saveCategory() {
    emit(EnteringBasicDataState(
        data: (NumericKeyboardButtonType.zero.value, DateTime.now())));
  }

  void _saveTransaction() {
    var transaction =
        Transaction(date: _date, comment: _enteredComment, amount: _amount);
    transaction.category.target = _selectedCategory;
    _transactionRepository.insertTransaction(transaction);
  }
}
