import 'package:finance_app/helper/expense_helper.dart';
import 'package:flutter/material.dart';

class IncomeExpenseInfoCard extends StatelessWidget {
  const IncomeExpenseInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 125,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        width: MediaQuery.of(context).size.width * 0.85,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 3,
              offset: const Offset(0, 10),
            )
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomeExpenseColumn(
                    type: 'Income', value: '₹ ${totalIncome()}'),
                Container(height: 50, width: 1, color: Colors.grey),
                IncomeExpenseColumn(
                    type: 'Expense', value: '₹ ${totalExpense()}'),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'You spent ₹ ${totalExpense().toString()} this month.\nYou saved a total ₹ ${totalBalance().toString()} this month.',
              style: const TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeExpenseColumn extends StatelessWidget {
  final String type;
  final String value;

  const IncomeExpenseColumn({Key? key, required this.type, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              type,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              type == 'Income' ? Icons.arrow_upward : Icons.arrow_downward,
              color: type == 'Income' ? const Color(0xff00838f) : Colors.grey,
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
