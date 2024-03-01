import '../views/numericKeyboard/onScreenNumericKeyboard.dart';

class AmountStringUpdater {
  final int _partWhole = 3; // count of numeric with point
  String currentAmount = "";

  String update(String? oldAmount, NumericKeyboardButtonType tappedButtonType) {
    String safetyOldAmount = oldAmount ?? "";

    if (safetyOldAmount.isEmpty) {
      return safetyOldAmount;
    }

    currentAmount = safetyOldAmount;

    switch (tappedButtonType) {
      case NumericKeyboardButtonType.delete:
        _deleteSymbol();
      case NumericKeyboardButtonType.empty:
        break;
      case NumericKeyboardButtonType.done:
        break;
      case NumericKeyboardButtonType.point:
        _addPoint();
      default:
        _addNumeric(tappedButtonType.value);
    }

    return currentAmount;
  }

  void _addPoint() {
    if ((!currentAmount.contains(NumericKeyboardButtonType.point.value))) {
      currentAmount += NumericKeyboardButtonType.point.value;
    }
  }

  void _deleteSymbol() {
    if (currentAmount.length > 1) {
      currentAmount = currentAmount.substring(0, currentAmount.length - 1);
    } else {
      currentAmount = NumericKeyboardButtonType.zero.value;
    }
  }

  void _addNumeric(String newNumeric) {
    if (currentAmount.contains(NumericKeyboardButtonType.point.value)) {
      var pointID =
          currentAmount.indexOf(NumericKeyboardButtonType.point.value);
      var partWholeLength =
          currentAmount.substring(pointID, currentAmount.length).length;
      if (partWholeLength < _partWhole) {
        currentAmount += newNumeric;
      }
    } else if (currentAmount == NumericKeyboardButtonType.zero.value) {
      currentAmount = newNumeric;
    } else {
      currentAmount += newNumeric;
    }
  }
}
