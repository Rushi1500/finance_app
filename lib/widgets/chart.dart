import 'package:finance_app/helper/expense_helper.dart';
import 'package:finance_app/models/expense_data_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  int index;
  bool showExpense;
  Chart({Key? key, required this.index, required this.showExpense})
      : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ExpenseDataChart> data = [];

  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        data = chartDayExpense(widget.showExpense);
        break;
      case 1:
        data = chartWeekExpense(widget.showExpense);
        break;
      case 2:
        data = chartMonthExpense(widget.showExpense);
        break;
      case 3:
        data = chartYearExpense(widget.showExpense);
        break;
      default:
    }

    return Container(
      width: double.infinity,
      height: 400,
      child: SfCircularChart(
        // Enables the legend
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries<ExpenseDataChart, String>>[
          // Initialize line series
          PieSeries<ExpenseDataChart, String>(
            dataSource: data,
            xValueMapper: (ExpenseDataChart sales, _) => sales.category,
            yValueMapper: (ExpenseDataChart sales, _) => sales.amount,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}
