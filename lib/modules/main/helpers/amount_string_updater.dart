import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';

class AmountStringUpdater {
  final int _partWhole = 3; // count of numeric with point

  String update(String oldValue, NumericKeyboardButtonType tappedButtonType) {
    switch (tappedButtonType) {
      case NumericKeyboardButtonType.delete:
       oldValue = _deleteSymbol(oldValue);
      case NumericKeyboardButtonType.empty:
        break;
      case NumericKeyboardButtonType.point:
        oldValue = _addPoint(oldValue);
      default:
        oldValue = _addNumeric(oldValue, tappedButtonType.value);
    }
    return oldValue;
  }

  String _addPoint(String oldValue) {
    if ((!oldValue.contains(NumericKeyboardButtonType.point.value))) {
      oldValue += NumericKeyboardButtonType.point.value;
    }
    return oldValue;
  }

  String _deleteSymbol(String oldValue) {
    if (oldValue.length > 1) {
      oldValue = oldValue.substring(0, oldValue.length - 1);
    } else {
      oldValue = NumericKeyboardButtonType.zero.value;
    }
    return oldValue;
  }

  String _addNumeric(String oldValue, String newNumeric) {
    if (oldValue.contains(NumericKeyboardButtonType.point.value)) {
      var pointID = oldValue.indexOf(NumericKeyboardButtonType.point.value);
      var partWholeLength = oldValue.substring(pointID, oldValue.length).length;
      if (partWholeLength < _partWhole) {
        oldValue += newNumeric;
      }
    } else if (oldValue == NumericKeyboardButtonType.zero.value) {
      oldValue = newNumeric;
    } else {
      oldValue += newNumeric;
    }
    return oldValue;
  }
}
