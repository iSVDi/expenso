import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/extensions/app_images.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:expenso/modules/history/models/select_category_model.dart';

class Chart extends StatefulWidget {
  final ChartModel data;
  final Function(Category category) selectCategoryHandler;
  final Function() changeChartModeHandler;
  final Function() resetChartModeHandler;

  const Chart(
      {Key? key,
      required this.data,
      required this.selectCategoryHandler,
      required this.changeChartModeHandler,
      required this.resetChartModeHandler})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    Widget chart;
    switch (widget.data.chartType) {
      case ChartType.bar:
        chart = _getBarChart(context);
      case ChartType.donut:
        chart = _getDonutChart();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      chart,
      _getCategoriesWidget(context),
    ]);
  }

  Widget _getBarChart(BuildContext context) {
    var theme = Theme.of(context);
    var axisesStyle = theme.textTheme.labelMedium
        ?.copyWith(color: theme.colorScheme.onBackground);
    var primaryYAxis = NumericAxis(
      labelStyle: axisesStyle,
      minimum: 0,
      maximum: widget.data.sum,
      opposedPosition: true,
    );
    var series = <CartesianSeries<SelectCategoryModel, String>>[
      BarSeries<SelectCategoryModel, String>(
        dataSource: widget.data.chartCategories.reversed.toList(),
        xValueMapper: (SelectCategoryModel data, _) => data.category.title,
        yValueMapper: (SelectCategoryModel data, _) => data.value,
        pointColorMapper: (datum, index) => datum.color,
      )
    ];

    var chart = SfCartesianChart(
      primaryXAxis: CategoryAxis(
        labelStyle: axisesStyle,
      ),
      primaryYAxis: primaryYAxis,
      series: series,
    );
    var buttons = _getNavigateTimeFrameButtons();
    var row = Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      buttons.$1,
      buttons.$2,
    ]);
    return Column(children: [
      chart,
      row,
    ]);
  }

  Widget _getDonutChart() {
    var chart = SfCircularChart(
      series: <CircularSeries<SelectCategoryModel, String>>[
        DoughnutSeries<SelectCategoryModel, String>(
          dataSource: widget.data.chartCategories.toList(),
          xValueMapper: (SelectCategoryModel data, _) => data.category.title,
          yValueMapper: (SelectCategoryModel data, _) => data.value,
          pointColorMapper: (datum, index) => datum.color,
          innerRadius: "85%",
        )
      ],
    );

    var buttons = _getNavigateTimeFrameButtons();
    var buttonsRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buttons.$1, buttons.$2]);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [chart, buttonsRow],
    );
  }

  (IconButton, IconButton) _getNavigateTimeFrameButtons() {
    var backButton = IconButton(
        onPressed: widget.data.backTimeFrameButtonHandler,
        icon: const Icon(Icons.arrow_back_ios));

    var forwardButton = IconButton(
        onPressed: widget.data.forwardTimeFrameButtonHandler,
        icon: const Icon(Icons.arrow_forward_ios));
    return (backButton, forwardButton);
  }

//TODO add percent for values on donut chart
  Widget _getCategoriesWidget(BuildContext context) {
    var textColor = Theme.of(context).colorScheme.background;
    var data = widget.data;
    var textStyle =
        Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor);
    var allCategories = data.selectedCategories + data.notSelectedCategories;
    var buttons = allCategories.map((e) {
      List<Widget> children;
      if (data.selectedCategories.contains(e)) {
        children = [
          Text(e.value.toStringAsFixed(0), style: textStyle),
          const SizedBox(width: 10),
          Text(e.category.title, style: textStyle),
        ];
      } else {
        children = [Text(e.category.title, style: textStyle)];
      }
      return _getSelectCategoryButton(
        rowChildren: children,
        model: e,
      );
    }).toList();

    var wrap = Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      runSpacing: 10,
      children: buttons,
    );

    var iconColor = Theme.of(context).colorScheme.primary;
    var resetButton = IconButton(
      style: IconButton.styleFrom(
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.only(bottom: 10)),
      onPressed: widget.resetChartModeHandler,
      icon: AppImages.refreshIcon.assetsImage(
        color: iconColor,
        width: 21,
        height: 24,
      ),
    );
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [resetButton, wrap]);
  }

  Widget _getSelectCategoryButton({
    required List<Widget> rowChildren,
    required SelectCategoryModel model,
  }) {
    var row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: rowChildren);

    var button = TextButton(
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        backgroundColor: model.color,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      ),
      onPressed: () {
        widget.selectCategoryHandler(model.category);
      },
      child: row,
    );
    return button;
  }
}
