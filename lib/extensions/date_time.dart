import "package:flutter/material.dart";
import "package:intl/intl.dart";

extension ConvenienceDateTime on DateTime {
  String get formattedDate {
    var formater = NumberFormat("00");
    var fDay = formater.format(day);
    var fMonth = formater.format(month);
    return "$fDay.$fMonth.$year";
  }

  String get formattedTime {
    var formater = NumberFormat("00");
    var fHour = formater.format(hour);
    var fMinute = formater.format(minute);
    return "$fHour:$fMinute";
  }

  DateTime fromDateTime(DateTime old) {
    return DateTime(old.year, old.month, old.day, hour, minute);
  }

  DateTime updateTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
