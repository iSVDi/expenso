import "package:flutter_bloc/flutter_bloc.dart";

import "package:expenso/modules/main/views/numericKeyboard/onScreenNumericKeyboard.dart";
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';

import "keyboardStates.dart";

class KeyboardCubit extends Cubit<KeyboardState> {
  final AmountStringUpdater _amountUpdater = AmountStringUpdater();

  // This values using only for keeping data
  double _amount = double.parse(NumericKeyboardButtonType.zero.value);
  DateTime _date = DateTime.now();

  String get getAmount => (state as EnteringBasicDataState).data.$1;
  DateTime get getDate => (state as EnteringBasicDataState).data.$2;

  KeyboardCubit()
      : super(EnteringBasicDataState(
            data: (NumericKeyboardButtonType.zero.value, DateTime.now())));

// *  Interface
  void updateAmount(NumericKeyboardButtonType buttonType) {
    var currentState = (state as EnteringBasicDataState);
    var oldValue = currentState.data.$1;
    var newValue = _amountUpdater.update(oldValue, buttonType);
    emit(EnteringBasicDataState(data: (newValue, currentState.data.$2)));
  }

  void saveAmount() {
    if (state is EnteringBasicDataState) {
      var currentState = (state as EnteringBasicDataState).data;
      _amount = double.parse(currentState.$1);
      _date = currentState.$2;
      emit(SelectingCategoriesState(data: null));
    }
  }

  void updateDate(DateTime date) {
    if (state is EnteringBasicDataState) {
      var currentState = (state as EnteringBasicDataState).data;
      var newState = EnteringBasicDataState(data: (currentState.$1, date));
      emit(newState);
    }
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
}
