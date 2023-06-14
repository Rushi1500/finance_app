import 'package:flutter/material.dart';

class Activity {
  IconData icon;
  String title;
  Color backgroundColor;
  Color iconColor;

  Activity(this.icon, this.title, this.backgroundColor, this.iconColor);

  List<Activity> getActivities() {
    return [
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
  }
}
