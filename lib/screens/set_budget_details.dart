import 'package:flutter/material.dart';

class SetBudgetDetails extends StatefulWidget {
  const SetBudgetDetails({Key? key}) : super(key: key);

  @override
  State<SetBudgetDetails> createState() => _SetBudgetDetailsState();
}

class _SetBudgetDetailsState extends State<SetBudgetDetails> {
  final TextEditingController budgetInputController = TextEditingController();
  FocusNode budgetFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x44000000),
        elevation: 0,
        title: const Text(
          'Food',
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
      body: buildTextField(
          budgetInputController, budgetFocus, "₹ 0.0", TextInputType.number),
    );
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
      child: TextField(
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
