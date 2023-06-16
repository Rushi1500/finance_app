import 'package:finance_app/helper/category_helper.dart';
import 'package:finance_app/screens/set_budget_details.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/models/add_data.dart';
import 'package:finance_app/helper/expense_helper.dart';

class Setbudget extends StatefulWidget {
  const Setbudget({Key? key}) : super(key: key);

  @override
  State<Setbudget> createState() => _SetbudgetState();
}

class _SetbudgetState extends State<Setbudget> {
  List types = ['Income', 'Expense'];
  int selectedIndex = 0;
  ValueNotifier notifier = ValueNotifier(0);

  List<String> selectedDateTimeValue = ['1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: const Text(
          'Budget Setting',
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
      body: buildCustomScroll(),
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
                  ...List.generate(2, (index) {
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
                        width: 100,
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
                          types[index],
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
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  print((selectedIndex == 0)
                      ? incomeCategories[index]
                      : expenseCategories[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetBudgetDetails(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                    title: Text(
                      (selectedIndex == 0)
                          ? incomeCategories[index]
                          : expenseCategories[index],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    trailing: Text(
                      '₹ 1000',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: (selectedIndex == 0)
                            ? const Color(0xff00838f)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: (selectedIndex == 0)
                ? incomeCategories.length
                : expenseCategories.length,
          ),
        )
      ],
    );
  }
}
