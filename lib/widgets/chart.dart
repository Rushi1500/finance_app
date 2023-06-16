import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<SalesData> salesData = [
    SalesData('Jan', 35000),
    SalesData('Feb', 2800),
    SalesData('Mar', 340),
    SalesData('Apr', 3222),
    SalesData('May', 4000),
    SalesData('June', 4000),
    SalesData('July', 4000),
    SalesData('Aug', 4000),
    SalesData('Sep', 4000),
    SalesData('Oct', 4000),
    SalesData('Nov', 4000),
    // SalesData('Dec', 4000),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            dataSource: salesData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
