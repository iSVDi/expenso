import 'package:flutter/material.dart';

class DateRangeHelper {
  static DateTimeRange getCurrentMonth() {
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month);
    var endDate = DateTime(startDate.year, startDate.month + 1);
    endDate = endDate.subtract(const Duration(days: 1));
    return DateTimeRange(start: startDate, end: endDate);
  }

  DateTimeRange calculateNewDateRange({
    required DateTimeRange currentDateRange,
    required bool toForward,
  }) {
    if (_isCurrentDateRangeOneMonth(currentDateRange)) {
      var now = currentDateRange.start;
      var month = toForward ? now.month + 1 : now.month - 1;
      var start = DateTime(now.year, month);
      var end = DateTime(start.year, start.month + 1)
          .subtract(const Duration(days: 1));
      return DateTimeRange(start: start, end: end);
    }
    var duration = currentDateRange.start.isAtSameMomentAs(currentDateRange.end)
        ? const Duration(days: 1)
        : currentDateRange.duration;

    var start = toForward
        ? currentDateRange.start.add(duration)
        : currentDateRange.start.subtract(duration);
    var end = toForward
        ? currentDateRange.end.add(duration)
        : currentDateRange.end.subtract(duration);
    var newDateRange = DateTimeRange(start: start, end: end);
    return newDateRange;
  }

  /*
*OK
dateRange                                 |-------------|    
calendarDateRange     |---------------------|                 

*OK
dateRange                                   |-------------|   
calendarDateRange     |---------------------|                 

!BAD
dateRange                                   |-------------|   
calendarDateRange     |---------------------|                 
    */
  bool needSetForwardHandler({required DateTimeRange currentDateRange}) {
    var newDateRangeForwardDuration = calculateNewDateRange(
            currentDateRange: currentDateRange, toForward: true)
        .duration;

    var res = currentDateRange.start
            .add(newDateRangeForwardDuration)
            .compareTo(getCalendarTimeRange().end) <=
        0;
    return res;
  }

  /*
*OK
dateRange               |-------------|
calendarDateRange     |---------------------| 

*OK
dateRange             |-------------|
calendarDateRange     |---------------------| 

!BAD
dateRange            |-------------|
calendarDateRange     |---------------------| 
    */
  bool needSetBackHandler({required DateTimeRange currentDateRange}) {
    var newDateRangeBackDuration = calculateNewDateRange(
            currentDateRange: currentDateRange, toForward: false)
        .duration;

    var res = currentDateRange.start
            .subtract(newDateRangeBackDuration)
            .compareTo(getCalendarTimeRange().start) >=
        0;
    return res;
  }

  bool _isCurrentDateRangeOneMonth(DateTimeRange currentDateRange) {
    var currentStart = currentDateRange.start;
    var monthStart = DateTime(currentStart.year, currentStart.month);
    var monthEnd = DateTime(monthStart.year, monthStart.month + 1)
        .subtract(const Duration(days: 1));
    var monthDateRange = DateTimeRange(start: monthStart, end: monthEnd);

    return currentDateRange == monthDateRange;
  }

  DateTimeRange getCalendarTimeRange() {
    var lastDate = DateTime.now();
    var firstDate =
        DateTime(lastDate.year - 1, lastDate.month, lastDate.day + 1);
    return DateTimeRange(start: firstDate, end: lastDate);
  }
}
