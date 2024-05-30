import "package:flutter/material.dart";

extension ConvenienceDateTime on DateTime {
  String get formattedDate {
    var fDay = day.toString().padLeft(2, "0");
    var fMonth = month.toString().padLeft(2, "0");
    return "$fDay.$fMonth.$year";
  }

  String get formattedTime {
    var fHour = hour.toString().padLeft(2, "0");
    var fMinute = minute.toString().padLeft(2, "0");
    return "$fHour:$fMinute";
  }

  DateTime fromDateTime(DateTime old) {
    return DateTime(old.year, old.month, old.day, hour, minute);
  }

  DateTime updateTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}
