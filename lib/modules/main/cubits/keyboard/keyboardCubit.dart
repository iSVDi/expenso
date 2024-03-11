import "package:expenso/modules/main/cubits/keyboard/keyboardRepository.dart";
import "package:expenso/modules/main/models/category.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:expenso/modules/main/views/numericKeyboard/onScreenNumericKeyboard.dart";
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';
import "keyboardStates.dart";

class KeyboardCubit extends Cubit<KeyboardState> {
  final _amountUpdater = AmountStringUpdater();
  final _repository = KeyboardRepository();

  // This values used only for keep data
  late double _amount;
  late DateTime _date;
  Category? _selectedCategory;
  String _enteredComment = "";

  String get getAmount => (state as EnteringBasicDataState).data.$1;
  DateTime get getDate => (state as EnteringBasicDataState).data.$2;

  KeyboardCubit()
      : super(EnteringBasicDataState(
            data: (NumericKeyboardButtonType.zero.value, DateTime.now())));

// *  Interface
  void doneButtonHandler() {
    if (state is EnteringBasicDataState) {
      _saveAmount();
    } else if (state is SelectingCategoriesState) {
      _saveCategory();
    } else {}
  }

  void updateDate(DateTime date) {
    if (state is EnteringBasicDataState) {
      var currentState = (state as EnteringBasicDataState).data;
      var newState = EnteringBasicDataState(data: (currentState.$1, date));
      emit(newState);
    }
  }

  void updateAmount(NumericKeyboardButtonType buttonType) {
    var currentState = (state as EnteringBasicDataState);
    var oldValue = currentState.data.$1;
    var newValue = _amountUpdater.update(oldValue, buttonType);
    emit(EnteringBasicDataState(data: (newValue, currentState.data.$2)));
  }

  bool isNeedSetBoldCategoryTitle(Category category) {
    var currentState = (state as SelectingCategoriesState).data;
    if (currentState != null) {
      var res = category.id == currentState.id;
      return res;
    }
    return false;
  }

  void selectCategory(Category category) {
    Category? currentCategory = (state as SelectingCategoriesState).data;
    Category? newCategory = category;
    bool areCategoriesSame =
        currentCategory != null && currentCategory!.id == category.id;

    if (areCategoriesSame) {
      newCategory = null;
    }

    emit(SelectingCategoriesState(data: newCategory));
  }

  void saveComment(String comment) {
    _enteredComment = comment;
    // todo save transaction
    emit(EnteringBasicDataState(
        data: (NumericKeyboardButtonType.zero.value, DateTime.now())));
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
    Category category = Category(id: 0, title: title);
    try {
      var res = await _repository.insert(category);
      print("category is added");
      selectCategory(res);
    } catch (e) {
      //TODO handle error
      print(e.toString());
    }
  }

  Future<List<Category>> getCategories() {
    return _repository.getCategories();
  }

  void _saveAmount() {
    var currentState = (state as EnteringBasicDataState).data;
    _amount = double.parse(currentState.$1);
    _date = currentState.$2;
    emit(SelectingCategoriesState(data: null));
  }

  void _saveCategory() {
    _selectedCategory = (state as SelectingCategoriesState).data;
    emit(EnteringComments(data: ""));
  }
}
