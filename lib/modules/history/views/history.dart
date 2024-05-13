import 'package:expenso/common/data_layer/models/transaction.dart';
import 'package:expenso/common/views/common_focused_menu_item.dart';
import 'package:expenso/extensions/app_images.dart';
import 'package:expenso/extensions/int.dart';
import 'package:expenso/l10n/gen_10n/app_localizations.dart';
import 'package:expenso/modules/history/cubit/history_cubit.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/views/chart.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_cell.dart';
import 'package:expenso/modules/main/views/transactions_list/transaction_view.dart';
import 'package:expenso/theme/theme_extensions/additional_colors.dart';
import 'package:expenso/theme/theme_extensions/divider_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    var iconButton = IconButton(
      onPressed: () async {
        var dateRange = cubit.getCalendarTimeRange();
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
      iconTheme: const IconThemeData(color: Colors.white),
      bottom: _getAppBarBottom(context),
      centerTitle: true,
      title: Text(AppLocalizations.of(context)!.expensesAnalysis,
          style: const TextStyle(color: Colors.white)),
      actions: [iconButton],
      backgroundColor:
          Theme.of(context).extension<AdditionalColors>()!.historyBarBackground,
    );
  }

  PreferredSizeWidget _getAppBarBottom(BuildContext context) {
    var weekButton = _getSetTimeRangeButton(
      context: context,
      title: AppLocalizations.of(context)!.spendInAWeek,
      icon: AppImages.calendarWeekBackground.assetsImage(),
      onPressed: () => _getCubit(context).weekTimeRangeHandler(),
    );

    var monthButton = _getSetTimeRangeButton(
      context: context,
      icon: AppImages.calendarMonthBackground.assetsImage(),
      title: AppLocalizations.of(context)!.spendInAMonth,
      onPressed: () => _getCubit(context).monthTimeRangeHandler(),
    );
    var prefferredSizeHeight = MediaQuery.of(context).size.height * 0.123;
    var stack = Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      SizedBox(
          width: double.maxFinite,
          height: prefferredSizeHeight / 1.7,
          child: ColoredBox(
              color: Theme.of(context)
                  .extension<AdditionalColors>()!
                  .historyBarBottom)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [weekButton, monthButton],
      )
    ]);

    var prefferredSize = PreferredSize(
        preferredSize: Size.fromHeight(prefferredSizeHeight), child: stack);

    return prefferredSize;
  }

  Widget _getSetTimeRangeButton(
      {required BuildContext context,
      required Widget icon,
      required String title,
      required Function()? onPressed}) {
    var size = MediaQuery.of(context).size;

    var width = size.width * 0.384;
    var height = size.height * 0.127;
    var textColor = Theme.of(context).colorScheme.onBackground;
    var textStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor);
    var button = IconButton(
      onPressed: onPressed,
      icon: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Stack(children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(title, style: textStyle),
          ),
        ]),
      ),
    );
    return button;
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
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: chart,
    );
    return padding;
  }

  Widget _getList(BuildContext context) {
    if (_getCubit(context).needPresentChartPlug()) {
      return _getListPlug(context);
    }
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
      sectionSeparatorBuilder: (context, section) {
        var isFirstSection = section == 0;
        var dividerExtension = Theme.of(context).extension<DividerColors>()!;

        var dividerColor = isFirstSection
            ? dividerExtension.historyFirstSection
            : dividerExtension.history;
        var divider = Divider(thickness: 1, color: dividerColor);

        var padding = Padding(
          padding: EdgeInsets.symmetric(horizontal: isFirstSection ? 0 : 32),
          child: divider,
        );
        return padding;
      },
    );

    return SafeArea(child: list);
  }

  Widget _getListPlug(BuildContext context) {
    var sideSize = MediaQuery.of(context).size.width * 0.595;
    var plug =
        AppImages.donutChartPlug.assetsImage(height: sideSize, width: sideSize);
    var textStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(letterSpacing: 0.01, height: 1.2);
    var text = Text(
      AppLocalizations.of(context)!.historyPlugTitle,
      style: textStyle,
    );

    var column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        plug,
        const SizedBox(height: 50),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32), child: text),
      ],
    );
    // var center = ;
    return SafeArea(child: Center(child: column));
  }

  Widget _getChartHeader(BuildContext context) {
    var cubit = _getCubit(context);
    var dateTitle = cubit.getChartHeaderTitle();
    var textTheme = _getTextTheme(context);
    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cubit.getSum().toStringAmount, style: textTheme.headlineLarge),
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

  Widget _itemBuilder(BuildContext context, Transaction transaction) {
    var viewItem = CommonFocusedMenuItem(
        context: context,
        title: Text(AppLocalizations.of(context)!.view),
        onPressed: () => _presentTransaction(context, transaction));

    var deleteItem = CommonFocusedMenuItem(
        context: context,
        title: Text(AppLocalizations.of(context)!.delete),
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
