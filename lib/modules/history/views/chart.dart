import 'package:expenso/common/data_layer/models/category.dart';
import 'package:expenso/extensions/date_time.dart';
import 'package:expenso/modules/history/cubit/history_state.dart';
import 'package:expenso/modules/history/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:expenso/modules/history/models/select_category_model.dart';

class Chart extends StatefulWidget {
  final ChartModel data;
  Function(Category category) selectCategoryHandler;
  Function() changeChartModeHandler;

  Chart(
      {Key? key,
      required this.data,
      required this.selectCategoryHandler,
      required this.changeChartModeHandler})
      : super(key: key);

  @override
  _ChartState createState() => _ChartState();
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
      _getHeader(),
      SizedBox(height: 200, child: chart),
      _getCategoriesButtons(),
    ]);
  }

  Widget _getHeader() {
    var timeFrame = widget.data.timeFrame;
    var dateTitle =
        "${timeFrame.start.formattedDate} - ${timeFrame.end.formattedDate}";

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.data.sum.toStringAsFixed(2)),
        Text(dateTitle),
      ],
    );
    var icon = Icon(widget.data.chartType == ChartType.bar
        ? Icons.donut_large_outlined
        : Icons.bar_chart_rounded);
    var button =
        IconButton(onPressed: widget.changeChartModeHandler, icon: icon);
    var row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        column,
        button,
      ],
    );
    return row;
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
    return chart;
  }

  Widget _getPieChart() {
    return SfCircularChart(
        series: <CircularSeries<SelectCategoryModel, String>>[
          DoughnutSeries<SelectCategoryModel, String>(
            dataSource: widget.data.chartCategories.toList(),
            xValueMapper: (SelectCategoryModel data, _) => data.category.title,
            yValueMapper: (SelectCategoryModel data, _) => data.value,
            pointColorMapper: (datum, index) => datum.color,
          )
        ]);
  }

  Widget _getCategoriesButtons() {
    var categories = widget.data.selectableCategories;
    return SizedBox(
      height: 300,
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
