import 'package:expenso/common/views/numericKeyboard/numeric_keyboard.dart';

// TODO? refactoring
extension ConvenienceString on String {
  int toIntAmount() {
    var pointId = indexOf(NumericKeyboardButtonType.point.value);
    var res = this;
    if (pointId == -1) {
      res += "00";
    } else {
      var partWholeLenght = length - pointId - 1; 
      res = res.replaceAll(RegExp("\\."), "");
      if (partWholeLenght == 1) {
        res += "0";
      }
    }
    return int.parse(res);
  }
}
