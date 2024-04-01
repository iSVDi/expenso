// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:expenso/modules/history/models/select_category_model.dart';

class BarChart extends StatefulWidget {
  final List<SelectCategoryModel> data;
  final double sum;

  const BarChart({
    Key? key,
    required this.data,
    required this.sum,
  }) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  // late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    // data = [
    //   _ChartData('CHN', 12),
    //   _ChartData('GER', 15),
    //   _ChartData('RUS', 30),
    //   _ChartData('BRZ', 6.4),
    //   _ChartData('IND', 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chart = SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: widget.sum,
            // interval: 10,
            opposedPosition: true),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<SelectCategoryModel, String>>[
          BarSeries<SelectCategoryModel, String>(
              dataSource: widget.data.reversed.toList(),
              xValueMapper: (SelectCategoryModel data, _) =>
                  data.category?.title ?? "no category",
              yValueMapper: (SelectCategoryModel data, _) => data.value,
              // name: 'Gold',
              color: Color.fromRGBO(8, 142, 255, 1))
        ]);
    return SizedBox(height: 200, child: chart);
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final String x;
  final double y;
}
