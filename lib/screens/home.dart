import 'package:finance_app/helper/expense_helper.dart';
import 'package:finance_app/helper/icon_helper.dart';
import 'package:finance_app/models/add_data.dart';
import 'package:finance_app/widgets/income_expense_info_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final box = Hive.box<AddData>('expense_data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
        backgroundColor: const Color(0x44000000),
        elevation: 0,
        title: const Text(
          'Available Balance',
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
        valueListenable: box.listenable(),
        builder: (context, value, child) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff00b686), Color(0xff00838f)],
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/4086/4086679.png'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Rushikesh Dhule',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.wallet,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        '₹ ${totalBalance().toString()}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      color: Colors.grey.shade100,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 75),
                        itemCount: box.values.toList().length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  box.values.toList()[index].delete();
                                });
                              },
                              key: UniqueKey(),
                              child:
                                  buildTransaction(box.values.toList()[index]));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const IncomeExpenseInfoCard(),
            ],
          );
        },
      ),
    );
  }

  Container buildTransaction(AddData data) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Icon(getIcon(data.category)),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        data.category,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${data.dateTime.day}-${data.dateTime.month}-${data.dateTime.year}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      data.explain,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '₹ ${data.amount}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: (data.IN == 'Income')
                          ? const Color(0xff00838f)
                          : Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
