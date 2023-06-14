import 'package:finance_app/models/activity.dart';
import 'package:finance_app/models/category.dart';
import 'package:finance_app/widgets/income_expense_info_card.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItemIndex = 0;

  final String balance = "50000";

  final List<Activity> activities = [
    Activity(
      Icons.card_membership,
      'My Card',
      Colors.blue.withOpacity(0.3),
      const Color(0xff01579b),
    ),
    Activity(
      Icons.transfer_within_a_station,
      'Transfer',
      Colors.cyanAccent.withOpacity(0.3),
      const Color(0xff01579b),
    ),
    Activity(
      Icons.pie_chart,
      'Statistics',
      const Color(0xffd7ccc8),
      const Color(0xff01579b),
    ),
  ];

  final List<Category> categories = [
    Category(Icons.fastfood, 'Food', 1200, 20),
    Category(Icons.fastfood, 'Food', 1200, 20),
    Category(Icons.fastfood, 'Food', 1200, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          buildBottomNavigationBarButton(context, Icons.home, 0),
          buildBottomNavigationBarButton(context, Icons.card_giftcard, 1),
          buildBottomNavigationBarButton(context, Icons.camera, 2),
          buildBottomNavigationBarButton(context, Icons.pie_chart, 3),
          buildBottomNavigationBarButton(context, Icons.person, 4),
        ],
      ),
      body: Stack(
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
                        children: const [
                          Icon(Icons.menu, color: Colors.white),
                          Text(
                            'Availale Balance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.notifications, color: Colors.white),
                        ],
                      ),
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
                                    Icons.wallet_giftcard,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    balance,
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
                  child: ListView(
                    padding: const EdgeInsets.only(top: 75),
                    children: [
                      const Text(
                        'Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List<Widget>.generate(
                          activities.length,
                          (index) => buildActivityButton(activities[index]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 15),
                      buildCategory(categories.first)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const IncomeExpenseInfoCard(),
        ],
      ),
    );
  }

  GestureDetector buildBottomNavigationBarButton(
      BuildContext context, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: Colors.green),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.3),
                    Colors.green.withOpacity(0.013),
                  ],
                ),
              )
            : const BoxDecoration(),
        height: 60,
        child: Icon(icon, color: Colors.grey),
      ),
    );
  }

  Container buildCategory(Category category) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    category.icon,
                    color: const Color(0xff00b686),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    category.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    category.amount.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    category.percentage.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Container buildActivityButton(Activity activity) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: activity.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            activity.icon,
            color: activity.iconColor,
          ),
          const SizedBox(height: 5),
          Text(
            activity.title,
            style: const TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
