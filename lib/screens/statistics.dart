import 'package:finance_app/models/getter.dart';
import 'package:finance_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  int selectedIndex = 0;
  List<SalesData> salesData = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 34),
    SalesData('Apr', 32),
    SalesData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Colors.green.withOpacity(0.3),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Container(
                //   height: 100,
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Color(0xff00b686), Color(0xff00838f)],
                //     ),
                //   ),
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.only(left: 20, right: 20, top: 30),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             IconButton(
                //               onPressed: () {},
                //               icon: const Icon(Icons.arrow_back,
                //                   color: Colors.white),
                //             ),
                //             const Text(
                //               'Statistics',
                //               style: TextStyle(
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w600,
                //                 color: Colors.white,
                //               ),
                //             ),
                //             IconButton(
                //               onPressed: () {},
                //               icon: const Icon(
                //                 Icons.attach_file_outlined,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ],
                //         ),
                //         const SizedBox(height: 20),
                //       ],
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(4, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
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
                          children: const [
                            Text(
                              'Expense',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_downward_sharp),
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
                const SizedBox(height: 10),
                Chart(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        'Top Spendings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: Image.network(
                    geter()[index].image!,
                    height: 40,
                    width: 40,
                  ),
                  title: Text(
                    geter()[index].name!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    geter()[index].time!,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text(geter()[index].fee!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: geter()[index].buy ?? false
                            ? const Color(0xff00838f)
                            : Colors.grey,
                      )),
                );
              },
              childCount: geter().length,
            ),
          )
        ],
      ),
    );
  }
}
