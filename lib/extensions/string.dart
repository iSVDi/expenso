import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';

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
