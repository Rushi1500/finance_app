import 'package:finance_app/models/budget_data.dart';
import 'package:hive/hive.dart';

final box = Hive.box<BudgetData>('budget_data');

int getBudgetValueFor(String category) {
  var budgetValue = 0;
  for (var i = 0; i < box.values.toList().length; i++) {
    if (box.values.toList()[i].category == category) {
      budgetValue = box.values.toList()[i].value;
      break;
    }
  }
  return budgetValue;
}

BudgetData? getBudgetObjectFor(String category) {
  BudgetData? budgetValue;
  for (var i = 0; i < box.values.toList().length; i++) {
    if (box.values.toList()[i].category == category) {
      budgetValue = box.values.toList()[i];
      break;
    }
  }
  return budgetValue;
}
