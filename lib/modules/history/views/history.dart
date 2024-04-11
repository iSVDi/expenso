import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/views/chart.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/modals.dart';
import 'package:group_list_view/group_list_view.dart';

class History extends StatelessWidget {
  const History({super.key});

  HistoryCubit _getCubit(BuildContext context) => context.read<HistoryCubit>();

  @override
  Widget build(BuildContext context) {
    var bloc = BlocBuilder<HistoryCubit, HistoryState>(
        builder: (context, state) => _getList(context));
    var scaffold = Scaffold(
      appBar: _getAppBar(context),
      body: bloc,
    );

    return scaffold;
  }

  AppBar _getAppBar(BuildContext context) {
    var cubit = _getCubit(context);
    var dateRange = cubit.getCalendarTimeRange;
    var iconButton = IconButton(
        onPressed: () async {
          var newDateRange = await showDateRangePicker(
              context: context,
              firstDate: dateRange.start,
              lastDate: dateRange.end);
          if (newDateRange != null) {
            cubit.updateDateRange(newDateRange);
          }
        },
        icon: const Icon(Icons.calendar_month_rounded));
    return AppBar(actions: [iconButton]);
  }

  Widget _getChart(BuildContext context) {
    var cubit = _getCubit(context);
    var data = cubit.getChartData();
    var chart = Chart(
      data: data,
      selectCategoryHandler: (category) =>
          cubit.selectCategoryHandler(category),
      changeChartModeHandler: () => cubit.changeModeHandler(),
      resetChartModeHandler: () => cubit.resetCategoriesHandler(),
    );
    return chart;
  }

  Widget _getList(BuildContext context) {
    var sectionsData = _getCubit(context).getHistoryListData();
    var list = GroupListView(
        sectionsCount: sectionsData.length + 1,
        countOfItemInSection: (sectionID) {
          if (sectionID == 0) {
            return 1;
          }
          return sectionsData[sectionID - 1].transactions.length;
        },
        itemBuilder: (itemBuilderContext, index) {
          if (index.section == 0) {
            return _getChart(context);
          }
          var transaction =
              sectionsData[index.section - 1].transactions[index.index];
          var item = _itemBuilder(itemBuilderContext, transaction);
          return item;
        },
        groupHeaderBuilder: (context, sectionID) {
          if (sectionID == 0) {
            return _getChartHeader(context);
          }
          var sectionDate = sectionsData[sectionID - 1];
          var header = _groupHeaderBuilder(
            sectionDate.headerDate,
            sectionDate.sum,
          );
          return header;
        });
    return list;
  }

  Widget _getChartHeader(BuildContext context) {
    var cubit = _getCubit(context);
    var dateTitle = cubit.getChartHeaderTitle();

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cubit.getSum().toStringAsFixed(2)),
        Text(dateTitle),
      ],
    );
    var icon = Icon(cubit.state.chartType == ChartType.bar
        ? Icons.donut_large_outlined
        : Icons.bar_chart_rounded);
    var button =
        IconButton(onPressed: () => cubit.changeModeHandler(), icon: icon);
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        column,
        button,
      ],
    );
    return row;
  }

// TODO localize
  Widget _itemBuilder(BuildContext context, Transaction transaction) {
    var viewItem = FocusedMenuItem(
        title: const Text("View"),
        onPressed: () => _presentTransaction(context, transaction));

    var deleteItem = FocusedMenuItem(
        title: const Text("Delete"),
        onPressed: () => _getCubit(context).deleteTransaction(transaction));

    var cell = TransactionCell(
      transaction: transaction,
      mode: TransactionCellMode.history,
      menuItems: [viewItem, deleteItem],
      onTap: () => _presentTransaction(context, transaction),
    );

    return cell;
  }

  void _presentTransaction(BuildContext context, Transaction transaction) {
    var transactionView = TransactionView(transaction: transaction);
    Navigator.push(
      context,
      MaterialPageRoute(builder: ((context) => transactionView)),
    );
  }

  Widget _groupHeaderBuilder(String title, String sum) {
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(sum.toString()),
      ],
    );
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: row,
    );
    var coloredBox = ColoredBox(
      //TODO change color
      color: Colors.greenAccent[100]!,
      child: padding,
    );
    return coloredBox;
  }
}
