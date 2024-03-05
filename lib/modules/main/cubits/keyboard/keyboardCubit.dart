import "package:expenso/modules/main/views/numericKeyboard/onScreenNumericKeyboard.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "keyboardStates.dart";
import 'package:expenso/modules/main/helpers/amountStringUpdater.dart';

class KeyboardCubit extends Cubit<KeyboardState> {
  final AmountStringUpdater amountUpdater = AmountStringUpdater();

  KeyboardCubit() : super(EnteringAmountState(data: "0"));

  String getAmount() => (state as EnteringAmountState).data;

  void updateAmount(NumericKeyboardButtonType buttonType) {
    var oldValue = (state as EnteringAmountState).data;
    var newValue = amountUpdater.update(oldValue, buttonType);
    emit(EnteringAmountState(data: newValue));
  }
}
