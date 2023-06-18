import 'package:finance_app/helper/icon_helper.dart';
import 'package:finance_app/models/add_data.dart';
import 'package:finance_app/helper/expense_helper.dart';
import 'package:finance_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final box = Hive.box<AddData>('expense_data');
  List day = ['Day', 'Week', 'Month', 'Year'];
  var showExpense = true;
  List expenseList = [today(), week(), month(), year()];
  List<AddData> selectedDateTimeValue = [];

  int selectedIndex = 0;
  ValueNotifier notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x44000000),
        elevation: 0,
        title: const Text(
          'Statistics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff00b686), Color(0xff00838f)],
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, dynamic value, child) {
          selectedDateTimeValue = expenseList[value];
          return buildCustomScroll();
        },
      ),
    );
  }

  CustomScrollView buildCustomScroll() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          notifier.value = index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: selectedIndex == index
                                ? [
                                    const Color(0xff00b686),
                                    const Color(0xff00838f)
                                  ]
                                : [Colors.white, Colors.white],
                          ),
                        ),
                        child: Text(
                          day[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  showExpense = !showExpense;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    showExpense ? 'Expense' : 'Income',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                      showExpense
                                          ? Icons.arrow_downward_sharp
                                          : Icons.arrow_upward_sharp,
                                      color: showExpense
                                          ? Colors.grey.shade700
                                          : Color(0xff00838f)),
                                ],
                              ))
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
              Chart(index: selectedIndex, showExpense: showExpense),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 40,
                  child: Icon(getIcon(selectedDateTimeValue[index].category)),
                ),
                title: Text(
                  selectedDateTimeValue[index].category,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${selectedDateTimeValue[index].dateTime.day}-${selectedDateTimeValue[index].dateTime.month}-${selectedDateTimeValue[index].dateTime.year}',
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Text('₹ ${selectedDateTimeValue[index].amount}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (selectedDateTimeValue[index].IN == 'Income')
                          ? const Color(0xff00838f)
                          : Colors.grey,
                    )),
              );
            },
            childCount: selectedDateTimeValue.length,
          ),
        )
      ],
    );
  }
}
