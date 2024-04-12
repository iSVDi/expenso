import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/extensions/app_colors.dart';
import 'package:expenso/extensions/app_images.dart';
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

  TextTheme _getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

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
      icon: AppImages.calendarIcon.assetsImage(width: 30, height: 24),
    );
    return AppBar(
      centerTitle: true,
      title: Text("анализ расходов",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.background)),
      actions: [iconButton],
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.background,
    );
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
    var padding = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32), child: chart);
    // return chart;
    return padding;
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
          context,
          sectionDate.headerDate,
          sectionDate.sum,
        );
        return header;
      },
      // },
      sectionSeparatorBuilder: (context, section) {
        var isFirstSection = section == 0;
        var color = isFirstSection
            ? const Color.fromRGBO(144, 144, 144, 1)
            : Theme.of(context).dividerTheme.color;

        var divider = Divider(thickness: 1, color: color);
        var padding = Padding(
          padding: EdgeInsets.symmetric(horizontal: isFirstSection ? 0 : 32),
          child: divider,
        );
        return padding;
      },
    );

    return list;
  }

  Widget _getChartHeader(BuildContext context) {
    var cubit = _getCubit(context);
    var dateTitle = cubit.getChartHeaderTitle();
    var textTheme = _getTextTheme(context);
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cubit.getSum().toStringAsFixed(2), style: textTheme.headlineLarge),
        Text(dateTitle, style: textTheme.labelLarge),
      ],
    );

    var icon = cubit.state.chartType == ChartType.bar
        ? AppImages.donutModeIcon
        : AppImages.barModeIcon;
    var button = IconButton(
        onPressed: () => cubit.changeModeHandler(),
        icon: icon.assetsImage(width: 36, height: 36));
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        column,
        button,
      ],
    );
    var padding = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32), child: row);
    // return row;
    return padding;
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

//TODO need format amount's text
  Widget _groupHeaderBuilder(BuildContext context, String title, String sum) {
    var textTheme = Theme.of(context).textTheme;
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        Text(sum, style: textTheme.headlineLarge),
      ],
    );
    var padding = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: row,
    );

    return padding;
  }
}
