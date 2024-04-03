import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:expenso/modules/history/models/select_category_model.dart';

class Chart extends StatefulWidget {
  final ChartModel data;
  final Function(Category category) selectCategoryHandler;
  final Function() changeChartModeHandler;

  const Chart(
      {Key? key,
      required this.data,
      required this.selectCategoryHandler,
      required this.changeChartModeHandler})
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
        chart = _getBarChart();
      case ChartType.donut:
        chart = _getPieChart();
    }
    return Column(children: [
      chart,
      _getCategoriesButtons(),
    ]);
  }

  Widget _getBarChart() {
    var primaryYAxis = NumericAxis(
      minimum: 0,
      maximum: widget.data.sum,
      opposedPosition: true,
    );
    var series = <CartesianSeries<SelectCategoryModel, String>>[
      BarSeries<SelectCategoryModel, String>(
        dataSource: widget.data.chartCategories.toList(),
        xValueMapper: (SelectCategoryModel data, _) => data.category.title,
        yValueMapper: (SelectCategoryModel data, _) => data.value,
        pointColorMapper: (datum, index) => datum.color,
      )
    ];

    var chart = SfCartesianChart(
      primaryXAxis: const CategoryAxis(),
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

  Widget _getPieChart() {
    var chart =
        SfCircularChart(series: <CircularSeries<SelectCategoryModel, String>>[
      DoughnutSeries<SelectCategoryModel, String>(
        dataSource: widget.data.chartCategories.toList(),
        xValueMapper: (SelectCategoryModel data, _) => data.category.title,
        yValueMapper: (SelectCategoryModel data, _) => data.value,
        pointColorMapper: (datum, index) => datum.color,
      )
    ]);

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

  Widget _getCategoriesButtons() {
    var categories = widget.data.selectableCategories;
    return SizedBox(
      height: 250,
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (builderContext, index) {
            var textStyle = const TextStyle(color: Colors.white);
            var row = Row(children: [
              Text(categories[index].value.toString(), style: textStyle),
              const SizedBox(width: 10),
              Text(categories[index].category.title, style: textStyle)
            ]);

            var button = TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(categories[index].color)),
                onPressed: () {
                  widget.selectCategoryHandler(categories[index].category);
                },
                child: row);
            return button;
          }),
    );
  }
}
