import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';

// TODO? refactoring
extension CovenienceInt on int {
  String get toStringAmount {
    if (this == 0) {
      return "$this";
    }
    if ("$this".length == 1) {
      return "0.0$this";
    }

    var list = toString().split("");
    var pointId = list.length - 2;
    var partWhole = list.sublist(pointId).join();
    if (partWhole == "00") {
      var res = list.sublist(0, pointId).join();
      return res;
    }
    list.insert(pointId, ".");
    if (pointId == 0) {
      list.insert(0, "0");
    }
    if (list.last == "0") {
      list.removeLast();
    }
    var res = list.join();
    return res;
  }
}

extension ConvenienceString on String {
  int toIntAmount() {
    var pointId = indexOf(NumericKeyboardButtonType.point.value);
    var numWithoutPoint = replaceAll(RegExp("\\."), "");
    numWithoutPoint += _getAdditionalZeros(pointId);
    return int.parse(numWithoutPoint);
  }

/*
*precision = 2
         part Whole Lenght | zeros count
!42        0               |  precision (this case is exception) 
*42.1      1               |  precision - 1 = 1
*42.11     2               |  precision - 2 = 0
*/

  String _getAdditionalZeros(int pointId) {
    var precision = 2;
    int zerosCount = precision; // if num hasn't point

    if (pointId >= 0) {
      var partWholeLenght = (length - 1 - pointId);
      zerosCount = precision - partWholeLenght;
    }

    var res = "0" * zerosCount;
    return res;
  }
}
