import 'package:finance_app/models/add_data.dart';
import 'package:finance_app/models/budget_data.dart';
import 'package:finance_app/screens/statistics.dart';
import 'package:finance_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<AddData>(AddDataAdapter());
  Hive.registerAdapter<BudgetData>(BudgetDataAdapter());
  await Hive.openBox<AddData>('expense_data');
  await Hive.openBox<BudgetData>('budget_data');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
