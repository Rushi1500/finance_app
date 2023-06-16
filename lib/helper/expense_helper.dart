import 'package:finance_app/models/add_data.dart';
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
      date = date.add(Duration(days: 1))) {
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
