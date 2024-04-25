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
