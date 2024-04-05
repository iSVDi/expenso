import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/modules/history/cubit/date_range_helper.dart';
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
  final dateRangeHelper = DateRangeHelper();

  DateTimeRange get getCalendarTimeRange =>
      dateRangeHelper.getCalendarTimeRange();
  // All transactions for current date range
  HistoryCubit()
      : super(HistoryState(
            dateRange: DateRangeHelper.getCurrentMonth(),
            transactions: TransactionRepository().readByDateRange(
                dateRange: DateRangeHelper.getCurrentMonth(),
                selectedCategories: {}),
            selectedCategories: {},
            chartType: ChartType.donut)) {
    _repository.registerObserver(this);
  }

  @override
  Future<void> close() {
    _repository.removeObserver(this);
    return super.close();
  }

//* Interface

  void updateDateRange(DateTimeRange dateRange) {
    var newTransactions = _repository.readByDateRange(
        dateRange: dateRange, selectedCategories: state.selectedCategories);
    _emitNewState(
        dateRange, newTransactions, state.selectedCategories, state.chartType);
  }

  double getSum() {
    if (state.transactions.isEmpty) {
      return 0;
    }

    var transactions = state.selectedCategories.isEmpty
        ? state.transactions
        : state.transactions
            .where((e) => state.selectedCategories.contains(e.category.target!))
            .toList();

    var sum = transactions
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
    return sum;
  }

  void changeModeHandler() {
    var newMode =
        state.chartType == ChartType.bar ? ChartType.donut : ChartType.bar;
    _emitNewState(
        state.dateRange, state.transactions, state.selectedCategories, newMode);
  }

  void selectCategoryHandler(Category category) {
    var newCategories = {...state.selectedCategories};

    if (newCategories.contains(category)) {
      newCategories.remove(category);
    } else {
      newCategories.add(category);
    }

    var newTransactions = _repository
        .readByDateRange(dateRange: state.dateRange, selectedCategories: {});
    _emitNewState(
        state.dateRange, newTransactions, newCategories, state.chartType);
  }

  void resetCategoriesHandler() {
    _emitNewState(state.dateRange, state.transactions, {}, state.chartType);
  }

  String getChartHeaderTitle() {
    var isOneDayDuration =
        state.dateRange.start.isAtSameMomentAs(state.dateRange.end);
    var dateRange = state.dateRange;
    if (isOneDayDuration) {
      return dateRange.start.formattedDate;
    }

    return "${dateRange.start.formattedDate} - ${dateRange.end.formattedDate}";
  }

  ChartModel getChartData() {
    var allCategories = _getCategoriesByTransactions();
    List<SelectCategoryModel> chartCategories() {
      if (state.selectedCategories.isEmpty) {
        return allCategories.toList();
      }
      var res = allCategories.where((element) {
        return state.selectedCategories.contains(element.category);
      }).toList();
      return res;
    }

    var needSetForwardHandler = dateRangeHelper.needSetForwardHandler(
        currentDateRange: state.dateRange);

    var needSetBackHandler =
        dateRangeHelper.needSetBackHandler(currentDateRange: state.dateRange);

    return ChartModel(
        sum: getSum(),
        chartType: state.chartType,
        chartCategories: chartCategories(),
        selectableCategories: allCategories,
        forwardTimeFrameButtonHandler:
            needSetForwardHandler ? _forwardTimeFrameHandler : null,
        backTimeFrameButtonHandler:
            needSetBackHandler ? _backTimeFrameHandler : null);
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

  void deleteTransaction(Transaction transaction) {
    _repository.deleteTransaction(transaction);
  }

//* Helpers
//TODO need sort by value and selecting status, refactoring
  List<SelectCategoryModel> _getCategoriesByTransactions() {
    // Mapping of categories with zero spendings
    var categoriesMap = Map.fromEntries(
        state.transactions.map((e) => MapEntry(e.category.target!, 0.0)));
    for (var transaction in state.transactions) {
      var category = transaction.category.target!;
      categoriesMap[category] = categoriesMap[category]! + transaction.amount;
    }

    var sum = getSum();

    var res = categoriesMap.entries.map((e) {
      var value =
          state.chartType == ChartType.bar ? e.value : (e.value * 100 / sum);
      var noNeedSetCustomOpacity = state.selectedCategories.contains(e.key) ||
          state.selectedCategories.isEmpty;
      var alphaColor = noNeedSetCustomOpacity ? 255 : 60;

      return SelectCategoryModel(
        category: e.key,
        value: noNeedSetCustomOpacity ? value : 0,
        color: _getCategoryColor(e.key.id).withAlpha(alphaColor),
      );
    }).toList();

    res.sort((a, b) => a.value > b.value ? -1 : 1);
    // res.
    return res;
  }

  void _forwardTimeFrameHandler() {
    var newDateRange = dateRangeHelper.calculateNewDateRange(
        currentDateRange: state.dateRange, toForward: true);
    updateDateRange(newDateRange);
  }

  void _backTimeFrameHandler() {
    var newDateRange = dateRangeHelper.calculateNewDateRange(
        currentDateRange: state.dateRange, toForward: false);
    updateDateRange(newDateRange);
  }

  @override
  void update() {
    var newTransactions = _repository.readByDateRange(
        dateRange: state.dateRange,
        selectedCategories: state.selectedCategories);
    _emitNewState(state.dateRange, newTransactions, state.selectedCategories,
        state.chartType);
  }

  void _emitNewState(DateTimeRange dateRange, List<Transaction> transactions,
      Set<Category> selectedCategories, ChartType chartType) {
    emit(
      HistoryState(
          dateRange: dateRange,
          transactions: transactions,
          selectedCategories: selectedCategories,
          chartType: chartType),
    );
  }

  Color _getCategoryColor(int id) {
    var colors = AppColors.getCategoryColors();
    return colors[id % colors.length];
  }
}
