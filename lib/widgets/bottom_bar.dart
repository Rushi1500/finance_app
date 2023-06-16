import 'package:finance_app/screens/add_expense.dart';
import 'package:finance_app/screens/home.dart';
import 'package:finance_app/screens/statistics.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigation();
}

class _BottomNavigation extends State<BottomNavigation> {
  int selected_index = 0;
  List screens = [Home(), Statistics()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selected_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpense(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff00838f),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected_index = 0;
                  });
                },
                child: Icon(
                  Icons.home_outlined,
                  color:
                      (selected_index == 0) ? Color(0xff00838f) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected_index = 1;
                  });
                },
                child: Icon(
                  Icons.bar_chart_outlined,
                  color:
                      (selected_index == 1) ? Color(0xff00838f) : Colors.grey,
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected_index = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color:
                      (selected_index == 2) ? Color(0xff00838f) : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selected_index = 3;
                  });
                },
                child: Icon(
                  Icons.person_outline,
                  color:
                      (selected_index == 3) ? Color(0xff00838f) : Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
