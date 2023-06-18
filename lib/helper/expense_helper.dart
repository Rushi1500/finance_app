import 'package:finance_app/models/add_data.dart';
import 'package:finance_app/models/expense_data_chart.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

final box = Hive.box<AddData>('expense_data');
final values = box.values.toList();

/// Home
int totalIncome() {
  var totalIncome = values.map((e) {
    if (e.IN == 'Income') {
      return e.amount;
    }
  });

  final List<String> nonNullList = totalIncome.whereType<String>().toList();
  return nonNullList.map((e) => int.parse(e)).toList().sum;
}

int totalExpense() {
  final totalExpense = values.map((e) {
    if (e.IN == 'Expense') {
      return e.amount;
    }
  });

  final List<String> nonNullList = totalExpense.whereType<String>().toList();
  return nonNullList.map((e) => int.parse(e)).toList().sum;
}

int totalBalance() {
  return (totalIncome() - totalExpense());
}

/// Statistics - Transactions
List<AddData> today() {
  final dateTimeNow = DateTime.now();
  String nowFormatedDate = DateFormat.yMMMEd().format(dateTimeNow);
  final today = values.map((e) {
    String selectedFormatedDate = DateFormat.yMMMEd().format(e.dateTime);
    if (nowFormatedDate.compareTo(selectedFormatedDate) == 0) {
      return e;
    }
  });
  return today.whereType<AddData>().toList();
}

List<AddData> week() {
  DateTime now = DateTime.now();
  DateTime startOfWeek = now.subtract(Duration(days: now.weekday));
  DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday - 1));
  List<DateTime> datesInRange = [];

  for (DateTime date = startOfWeek;
      date.isBefore(endOfWeek) || date == endOfWeek;
      date = date.add(const Duration(days: 1))) {
    datesInRange.add(date);
  }

  List<AddData> weekData = [];
  for (var i = 0; i < datesInRange.length; i++) {
    String nowFormatedDate = DateFormat.yMMMEd().format(datesInRange[i]);

    final today = values.map((e) {
      String selectedFormatedDate = DateFormat.yMMMEd().format(e.dateTime);
      if (nowFormatedDate.compareTo(selectedFormatedDate) == 0) {
        return e;
      }
    });

    weekData += today.whereType<AddData>().toList();
  }

  return weekData;
}

List<AddData> month() {
  final dateTimeNow = DateTime.now();
  final month = values.map((e) {
    if (e.dateTime.month == dateTimeNow.month) {
      return e;
    }
  });
  return month.whereType<AddData>().toList();
}

List<AddData> year() {
  final dateTimeNow = DateTime.now();
  final year = values.map((e) {
    if (e.dateTime.year == dateTimeNow.year) {
      return e;
    }
  });
  return year.whereType<AddData>().toList();
}

/// Statistics - Chart

List<ExpenseDataChart> chartDayExpense(bool showExpense) {
  final yearData = today();
  var hours = yearData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.category;
    }
  }).toList();

  var hoursExpense = yearData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.amount;
    }
  }).toList();

  List<ExpenseDataChart> list = [];
  for (var i = 0; i < hours.length; i++) {
    if (hours[i] != null) {
      list.add(ExpenseDataChart(
          hours[i].toString(), int.parse(hoursExpense[i].toString())));
    }
  }

  return getFilteredData(list);
}

List<ExpenseDataChart> chartWeekExpense(bool showExpense) {
  final weekData = week();
  var weekDays = weekData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.category;
    }
  }).toList();

  var weekExpense = weekData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.amount;
    }
  }).toList();

  List<ExpenseDataChart> list = [];
  for (var i = 0; i < weekDays.length; i++) {
    if (weekDays[i] != null) {
      list.add(ExpenseDataChart(
          weekDays[i].toString(), int.parse(weekExpense[i].toString())));
    }
  }

  return getFilteredData(list);
}

List<ExpenseDataChart> chartMonthExpense(bool showExpense) {
  final monthData = month();
  var months = monthData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.category;
    }
  }).toList();

  var monthExpense = monthData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.amount;
    }
  }).toList();

  List<ExpenseDataChart> list = [];
  for (var i = 0; i < months.length; i++) {
    if (months[i] != null) {
      list.add(ExpenseDataChart(
          months[i].toString(), int.parse(monthExpense[i].toString())));
    }
  }

  return getFilteredData(list);
}

List<ExpenseDataChart> chartYearExpense(bool showExpense) {
  final yearData = year();
  var years = yearData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.category;
    }
  }).toList();

  var yearExpense = yearData.map((e) {
    if (showExpense ? e.IN == 'Expense' : e.IN == 'Income') {
      return e.amount;
    }
  }).toList();

  List<ExpenseDataChart> list = [];
  for (var i = 0; i < years.length; i++) {
    if (years[i] != null) {
      list.add(ExpenseDataChart(
          years[i].toString(), int.parse(yearExpense[i].toString())));
    }
  }
  return getFilteredData(list);
}

List<ExpenseDataChart> getFilteredData(List<ExpenseDataChart> list) {
  Map<String, ExpenseDataChart> output = {};

  list.forEach((expense) {
    if (output.containsKey(expense.category)) {
      output[expense.category]!.amount += expense.amount;
    } else {
      output[expense.category] =
          ExpenseDataChart(expense.category, expense.amount);
    }
  });

  return output.values.toList();
}
