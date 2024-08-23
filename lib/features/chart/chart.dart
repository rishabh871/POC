import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<_ChartData> chartData;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    chartData = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  List<_PieData> dataSource = [
    _PieData('Jan', 35, 'Jan'),
    _PieData('Feb', 28, 'Jan'),
    _PieData('Mar', 34, 'Jan'),
    _PieData('Apr', 32, 'Jan'),
    _PieData('May', 40, 'Jan')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Half yearly sales analysis'),
                // Enable legend
                legend: const Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true))
                ]),
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //Initialize the spark charts widget
                child: SfSparkLineChart.custom(
                  //Enable the trackball
                  trackball: const SparkChartTrackball(
                      activationMode: SparkChartActivationMode.tap),
                  //Enable marker
                  marker: const SparkChartMarker(
                      displayMode: SparkChartMarkerDisplayMode.all),
                  //Enable data label
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  xValueMapper: (int index) => data[index].year,
                  yValueMapper: (int index) => data[index].sales,
                  dataCount: 5,
                ),
              ),
            ),
            Center(
                child: SfCircularChart(
                    title: ChartTitle(text: 'Sales by sales person'),
                    legend: const Legend(isVisible: true),
                    series: <PieSeries<_PieData, String>>[
                  PieSeries<_PieData, String>(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: dataSource,
                      xValueMapper: (_PieData data, _) => data.xData,
                      yValueMapper: (_PieData data, _) => data.yData,
                      dataLabelMapper: (_PieData data, _) => data.text,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true)),
                ])),
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, maximum: 40, interval: 10),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      name: 'Gold',
                      color: const Color.fromRGBO(8, 142, 255, 1))
                ]),
            SfCircularChart(series: <CircularSeries>[
              // Renders radial bar chart
              RadialBarSeries<_ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y)
            ]),

            Center(
                child: SfFunnelChart(
                    series: FunnelSeries<_ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y))),

            SfCartesianChart(
                isTransposed: true,
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  SplineSeries<_ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y)
                ]),
          ]),
        ));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);

  final String xData;
  final num yData;
  final String text;
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _CandleChartData {
  _CandleChartData(this.x, this.open, this.high, this.low, this.close);

  final double x;
  final double open;
  final double high;
  final double low;
  final double close;
}
