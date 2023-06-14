import 'package:flutter/material.dart';
import 'package:finance_app/models/category.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  List<Category> categories = [
    Category(Icons.fastfood, 'Food', 1200, 20),
    Category(Icons.fastfood, 'Utility', 1200, 20),
    Category(Icons.fastfood, 'Fashion', 1200, 20),
  ];

  Category? selectedCategory;
  final TextEditingController explainExpenseController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  FocusNode explainFocus = FocusNode();
  FocusNode amountFocus = FocusNode();
  DateTime dateNow = DateTime.now();

  @override
  void initState() {
    super.initState();
    explainFocus.addListener(() {
      setState(() {});
    });

    amountFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff00b686), Color(0xff00838f)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          const Text(
                            'Add Expense',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 120,
            child: Container(
              height: 500,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    spreadRadius: 3,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  buildDropDownButton(),
                  const SizedBox(height: 20),
                  buildTextField(explainExpenseController, explainFocus,
                      'Expain expense', TextInputType.text),
                  const SizedBox(height: 20),
                  buildTextField(amountController, amountFocus, 'Amount',
                      TextInputType.number),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xffc5c5c5),
                      ),
                    ),
                    width: 300,
                    child: TextButton(
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: dateNow,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        if (newDate == Null) return;
                        setState(() {
                          dateNow = newDate!;
                        });
                      },
                      child: Text(
                        'Date : ${dateNow.day}/${dateNow.month}/${dateNow.year}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: const Color(0xffc5c5c5),
                      ),
                    ),
                    width: 150,
                    height: 50,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
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

  Padding buildDropDownButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffc5c5c5),
          ),
        ),
        child: DropdownButton<Category>(
          value: selectedCategory,
          items: categories
              .map(
                (e) => DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Icon(
                            e.icon,
                            color: const Color(0xff00b686),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.title,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          selectedItemBuilder: (context) {
            return categories
                .map((e) => Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Icon(e.icon),
                        ),
                        const SizedBox(width: 10),
                        Text(e.title),
                      ],
                    ))
                .toList();
          },
          onChanged: ((value) {
            setState(() {
              selectedCategory = value;
            });
          }),
          hint: const Text(
            'Category Type',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }
}
