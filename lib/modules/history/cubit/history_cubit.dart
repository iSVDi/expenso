import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/history/models/history_section_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expenso/modules/history/cubit/history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final _repository = TransactionRepository();

  HistoryCubit()
      : super(HistoryState(
          timeFrame: getCurrentMonth(),
          selectedCategories: [],
        ));

  List<SectionHistory> getHistoryListData() {
    var transactions = _repository.readByDateRange(state.timeFrame);

    //Map <28.03.2024, [Transaction]>
    Map<String, List<Transaction>> transactionsMap = {};

    for (var transaction in transactions) {
      var dateString = transaction.date.formattedDate;
      var isNewDate = !transactionsMap.keys.toSet().contains(dateString);
      if (isNewDate) {
        transactionsMap[dateString] = [];
      }
      transactionsMap[dateString]?.add(transaction);
    }

    var res = transactionsMap.entries.map((sectionData) {
      var sectionHistory = SectionHistory(
          headerDate: sectionData.value.first.date.formattedDate,
          sum: sectionData.value
              .map((e) => e.amount)
              .reduce((value, element) => value + element)
              .toString(),
          transactions: sectionData.value);
      return sectionHistory;
    }).toList();
    return res;
  }

  static DateTimeRange getCurrentMonth() {
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month);
    var endDate = DateTime(startDate.year, now.month + 1);
    return DateTimeRange(start: startDate, end: endDate);
  }
}
