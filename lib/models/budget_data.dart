import 'package:hive/hive.dart';
part 'budget_data.g.dart';

@HiveType(typeId: 2)
class BudgetData extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  int value;

  BudgetData(this.category, this.value);
}
