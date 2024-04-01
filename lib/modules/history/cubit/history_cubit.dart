import 'dart:math';

import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/modules/history/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/common/data_layer/repositories/transactions_repository.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/history_section_model.dart';
import 'package:expenso/modules/history/models/select_category_model.dart';

class HistoryCubit extends Cubit<HistoryState> implements RepositoryObserver {
  final _repository = TransactionRepository();
  // All transactions for current time frame
  HistoryCubit()
      : super(HistoryState(
            timeFrame: _getCurrentMonth(),
            transactions: TransactionRepository().readByDateRange(
                dateRange: _getCurrentMonth(), selectedCategories: {}),
            selectedCategories: {},
            chartType: ChartType.bar));

  double _getSum() {
    var sum = state.transactions
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
    return sum;
  }

  void changeModeHandler() {
    var newMode =
        state.chartType == ChartType.bar ? ChartType.pie : ChartType.bar;
    emit(HistoryState(
      timeFrame: state.timeFrame,
      transactions: state.transactions,
      selectedCategories: state.selectedCategories,
      chartType: newMode,
    ));
  }

  void selectCategoryHandler(Category? category) {
    var newCategories = {...state.selectedCategories};

    if (newCategories.contains(category)) {
      newCategories.remove(category);
    } else {
      newCategories.add(category);
    }

    emit(HistoryState(
        timeFrame: state.timeFrame,
        transactions: state.transactions,
        selectedCategories: newCategories,
        chartType: state.chartType));
  }

  void resetCategoriesHandler() {
    emit(HistoryState(
        timeFrame: state.timeFrame,
        transactions: state.transactions,
        selectedCategories: {},
        chartType: state.chartType));
  }

  // TODO rename and refactoring
  List<SelectCategoryModel> getCategories() {
    Map<Category?, double> categoriesMap = {};

    for (var transaction in state.transactions) {
      var category = transaction.category.target;
      var isCategoryInMap = categoriesMap.keys.toSet().contains(category);
      if (!isCategoryInMap) {
        categoriesMap[category] = transaction.amount;
      } else {
        categoriesMap[category] = categoriesMap[category]! + transaction.amount;
      }
    }

    var sum = _getSum();

    var res = categoriesMap.entries.map((e) {
      var value =
          state.chartType == ChartType.bar ? e.value : (e.value * 100 / sum);
      var alphaColor = state.selectedCategories.contains(e.key) ||
              state.selectedCategories.isEmpty
          ? 255
          : 60;
      return SelectCategoryModel(
        category: e.key,
        value: value,
        color: getCategoryColor(e.key?.id).withAlpha(alphaColor),
      );
    }).toList();

    res.sort((a, b) {
      if (a.value > b.value) {
        return -1;
      }
      return 1;
    });
    return res;
  }

  ChartModel getChartData() {
    var selectableCategories = getCategories();
    List<SelectCategoryModel> chartCategories() {
      if (state.selectedCategories.isEmpty) {
        return selectableCategories.reversed.toList();
      }
      var res = selectableCategories.reversed.where((element) {
        return state.selectedCategories.contains(element.category);
      }).toList();
      return res;
    }

    return ChartModel(
      sum: _getSum(),
      chartType: state.chartType,
      timeFrame: state.timeFrame,
      chartCategories: chartCategories(),
      selectableCategories: selectableCategories,
    );
  }

  List<SectionHistory> getHistoryListData() {
    //Map <28.03.2024, [Transaction]>
    Map<String, List<Transaction>> transactionsMap = {};

    for (var transaction in state.transactions) {
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

  @override
  void update() {
    var newTransactions = _repository.readByDateRange(
        dateRange: state.timeFrame,
        selectedCategories: state.selectedCategories);

    emit(HistoryState(
      timeFrame: state.timeFrame,
      transactions: newTransactions,
      selectedCategories: state.selectedCategories,
      chartType: state.chartType,
    ));
  }

  //TODO fix for current month
  static DateTimeRange _getCurrentMonth() {
    var now = DateTime.now();
    var startDate = DateTime(now.year, now.month - 1);
    var endDate = DateTime(startDate.year, now.month);
    return DateTimeRange(start: startDate, end: endDate);
  }

  Color getCategoryColor(int? id) {
    var colors = AppColors.getCategoryColors();
    if (id != null) {
      return colors[id % colors.length];
    }
    return colors.last;
  }
}
