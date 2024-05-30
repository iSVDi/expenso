import 'package:expenso/extensions/amount_converter.dart';
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
  final List<Color> _categoryColors = [
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow,
    Colors.cyanAccent,
    Colors.pink,
  ];

  DateTimeRange getCalendarTimeRange() {
    var start = _repository.readEarliestTransactionDate() ?? DateTime.now();
    var end = DateTime.now();
    return DateTimeRange(start: start, end: end);
  }

  // All transactions for current date range
  HistoryCubit()
      : super(HistoryState(
            dateRange: DateRangeHelper.getCurrentMonth(),
            transactions: TransactionRepository().readByDateRange(
              dateRange: DateRangeHelper.getCurrentMonth(),
            ),
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
    var newTransactions = _repository.readByDateRange(dateRange: dateRange);
    _emitNewState(dateRange, newTransactions, {}, state.chartType);
  }

  int getSum() {
    if (state.transactions.isEmpty) {
      return 0;
    }

    var transactions = state.selectedCategories.isEmpty
        ? state.transactions
        : state.transactions
            .where((e) => state.selectedCategories.contains(e.category.target))
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
      state.dateRange,
      state.transactions,
      state.selectedCategories,
      newMode,
    );
  }

  void selectCategoryHandler(Category? category) {
    var newCategories = {...state.selectedCategories};

    if (newCategories.contains(category)) {
      newCategories.remove(category);
    } else {
      newCategories.add(category);
    }

    var newTransactions = _repository.readByDateRange(
      dateRange: state.dateRange,
    );
    _emitNewState(
      state.dateRange,
      newTransactions,
      newCategories,
      state.chartType,
    );
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

  bool needPresentChartPlug() => _repository.readTransactionsCount() == 0;

  ChartModel getChartData() {
    var allCategories = _getCategoriesByTransactions();
    List<SelectCategoryModel> chartCategories() {
      if (state.selectedCategories.isEmpty) {
        return allCategories.reduce((value, element) => value + element);
      }
      return allCategories[0];
    }

    List<SelectCategoryModel> selectedCategories =
        state.selectedCategories.isEmpty ? allCategories[1] : allCategories[0];
    List<SelectCategoryModel> notSelectedCategories =
        state.selectedCategories.isEmpty ? [] : allCategories[1];

    return ChartModel(
        sum: getSum(),
        chartType: state.chartType,
        chartCategories: chartCategories(),
        selectedCategories: selectedCategories,
        notSelectedCategories: notSelectedCategories,
        forwardTimeFrameButtonHandler: _getForwardHandler(),
        backTimeFrameButtonHandler: _getBackHandler());
  }

/*
*OK
rightLimit                              |
calendarDateRange     |---------------------| 

*OK
rightLimit            |    
calendarDateRange     |---------------------| 

!BAD
rightLimit           |
calendarDateRange     |---------------------| 
*/

  Function()? _getForwardHandler() {
    var rightLimit = DateTime.now();

    var dateRange = dateRangeHelper.calculateNewDateRange(
        currentDateRange: state.dateRange, toForward: true);
    var canSetForwardHandler = rightLimit.compareTo(dateRange.start) >= 0;
    if (canSetForwardHandler) {
      handler() => updateDateRange(dateRange);
      return handler;
    }

    return null;
  }

/*
*OK
leftLimit                     |
calendarDateRange     |---------------------| 

*OK
leftLimit                                   |
calendarDateRange     |---------------------| 

!BAD
leftLimit                                     |
calendarDateRange     |---------------------| 
*/
  Function()? _getBackHandler() {
    var leftLimit = _repository.readEarliestTransactionDate();
    if (leftLimit != null) {
      var dateRange = dateRangeHelper.calculateNewDateRange(
          currentDateRange: state.dateRange, toForward: false);
      var canSetBackHandler = leftLimit.compareTo(dateRange.end) <= 0;
      if (canSetBackHandler) {
        handler() => updateDateRange(dateRange);
        return handler;
      }
    }
    return null;
  }

  List<SectionHistory> getHistoryListData() {
    var transactions = state.selectedCategories.isEmpty
        ? state.transactions
        : state.transactions
            .where((element) =>
                state.selectedCategories.contains((element.category.target)))
            .toList();

    //Map <28.03.2024, [Transaction]>
    Map<String, List<Transaction>> transactionsMap = Map.fromEntries(
        transactions.map((e) => MapEntry(e.date.formattedDate, [])));

    for (var transaction in transactions) {
      var dateString = transaction.date.formattedDate;
      transactionsMap[dateString]?.add(transaction);
    }

    var res = transactionsMap.entries.map((sectionData) {
      var sectionHistory = SectionHistory(
          headerDate: sectionData.value.first.date.formattedDate,
          sum: sectionData.value
              .map((e) => e.amount)
              .reduce((value, element) => value + element)
              .toStringAmount,
          transactions: sectionData.value);
      return sectionHistory;
    }).toList();
    return res;
  }

  void deleteTransaction(Transaction transaction) {
    _repository.deleteTransaction(transaction);
  }

//* Helpers
  ///return: [selected categories, not selected categories]
  List<List<SelectCategoryModel>> _getCategoriesByTransactions() {
    // Mapping of categories with zero spendings
    var categoriesMap = Map.fromEntries(
        state.transactions.map((e) => MapEntry(e.category.target, 0)));
    for (var transaction in state.transactions) {
      var category = transaction.category.target;
      categoriesMap[category] = categoriesMap[category]! + transaction.amount;
    }

    var sum = getSum();
    List<SelectCategoryModel> selectedCategories = [];
    List<SelectCategoryModel> notSelectedCategories = [];

    for (var e in categoriesMap.entries) {
      var value = state.chartType == ChartType.bar
          ? e.value.toStringAmount
          : "${e.value * 100 ~/ sum}";
      var noNeedSetCustomOpacity = state.selectedCategories.contains(e.key) ||
          state.selectedCategories.isEmpty;
      var alphaColor = noNeedSetCustomOpacity ? 255 : 60;

      var model = SelectCategoryModel(
        category: e.key,
        value: double.parse(value),
        color: _getCategoryColor(e.key?.id).withAlpha(alphaColor),
      );
      if (state.selectedCategories.contains(e.key)) {
        selectedCategories.add(model);
      } else {
        notSelectedCategories.add(model);
      }
    }

    selectedCategories.sort((a, b) => a.value > b.value ? -1 : 1);
    notSelectedCategories.sort((a, b) => a.value > b.value ? -1 : 1);

    var res = [selectedCategories, notSelectedCategories];
    return res;
  }

  @override
  void update() {
    var newTransactions =
        _repository.readByDateRange(dateRange: state.dateRange);
    var categories = newTransactions.map((e) => e.category.target);
    var newSelectedCategories = state.selectedCategories
        .where((element) => categories.contains(element))
        .toSet();
    _emitNewState(
      state.dateRange,
      newTransactions,
      newSelectedCategories,
      state.chartType,
    );
  }

  void _emitNewState(DateTimeRange dateRange, List<Transaction> transactions,
      Set<Category?> selectedCategories, ChartType chartType) {
    emit(
      HistoryState(
          dateRange: dateRange,
          transactions: transactions,
          selectedCategories: selectedCategories,
          chartType: chartType),
    );
  }

  Color _getCategoryColor(int? id) {
    if (id == null) {
      return _categoryColors[0];
    }

    var length = _categoryColors.length;
    return _categoryColors[id % length];
  }
}
