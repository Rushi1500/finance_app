import 'package:finance_app/helper/icon_helper.dart';
import 'package:finance_app/models/add_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final box = Hive.box<AddData>('expense_data');

  List<String> categories = [
    'Food',
    'Utility',
    'Fashion',
    'Taxes',
    'Rent',
    'Insurance',
    'Business',
    'Job',
    'Other'
  ];
  List<String> incomeOrExpense = ['Income', 'Expense'];

  String? selectedCategory;
  String? selectedIncomeExpenseType;

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
                  padding: const EdgeInsets.only(right: 20, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                            ),
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
                  buildCategoriesDropDown(),
                  const SizedBox(height: 20),
                  buildTextField(explainExpenseController, explainFocus,
                      'Explain expense', TextInputType.text),
                  const SizedBox(height: 20),
                  buildTextField(amountController, amountFocus, 'Amount',
                      TextInputType.number),
                  const SizedBox(height: 20),
                  buildIncomeExpenseDropDown(),
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

  save() {
    var addExpenseOrIncome = AddData(
        selectedCategory!,
        explainExpenseController.text,
        amountController.text,
        selectedIncomeExpenseType!,
        dateNow);
    box.add(addExpenseOrIncome);
    setState(() {
      // selectedCategory = '';
      explainExpenseController.clear();
      amountController.clear();
      // selectedIncomeExpenseType = '';
      dateNow = DateTime.now();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Expense saved successfully"),
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

  Padding buildCategoriesDropDown() {
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
        child: DropdownButton<String>(
          value: selectedCategory,
          items: categories
              .map(
                (e) => DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        // SizedBox(
                        //   width: 40,
                        //   child: Icon(e.icon),
                        // ),
                        const SizedBox(width: 10),
                        Text(
                          e,
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
                          child: Icon(getIcon(e)),
                        ),
                        const SizedBox(width: 10),
                        Text(e),
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

  Padding buildIncomeExpenseDropDown() {
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
        child: DropdownButton<String>(
          value: selectedIncomeExpenseType,
          items: incomeOrExpense
              .map(
                (e) => DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Icon(
                            (e == 'Income')
                                ? Icons.arrow_circle_up
                                : Icons.arrow_circle_down,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e,
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
            return incomeOrExpense
                .map((e) => Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Icon(
                            (e == 'Income')
                                ? Icons.arrow_circle_up
                                : Icons.arrow_circle_down,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(e),
                      ],
                    ))
                .toList();
          },
          onChanged: ((value) {
            setState(() {
              selectedIncomeExpenseType = value;
            });
          }),
          hint: const Text(
            'Income / Expense',
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
