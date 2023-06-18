import 'package:finance_app/models/budget_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SetBudgetDetails extends StatefulWidget {
  final String category;
  final int alreaySetValue;
  SetBudgetDetails(
      {Key? key, required this.category, required this.alreaySetValue})
      : super(key: key);

  @override
  State<SetBudgetDetails> createState() => _SetBudgetDetailsState();
}

class _SetBudgetDetailsState extends State<SetBudgetDetails> {
  final box = Hive.box<BudgetData>('budget_data');
  final TextEditingController budgetInputController = TextEditingController();

  FocusNode budgetFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x44000000),
        elevation: 0,
        title: Text(
          widget.category,
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(height: 30),
            buildTextField(budgetInputController, budgetFocus, '₹ 0.0',
                TextInputType.number),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                save();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xff00838f),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() {
    var budget =
        BudgetData(widget.category, int.parse(budgetInputController.text));

    if (box.values.toList().isEmpty) {
      box.add(budget);
    } else {
      if (box.values
          .toList()
          .map((e) => e.category)
          .contains(budget.category)) {
        for (var i = 0; i < box.values.toList().length; i++) {
          if (box.values.toList()[i].category == budget.category) {
            box.putAt(i, budget);
          }
        }
      } else {
        box.add(budget);
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Budget saved successfully"),
      ),
    );
    Navigator.of(context).pop();
  }

  Container buildTextField(TextEditingController controller,
      FocusNode focusNode, String hint, TextInputType textInputType) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: const Color(0xffc5c5c5),
        ),
      ),
      child: TextFormField(
        keyboardType: textInputType,
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
