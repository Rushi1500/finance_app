import 'package:flutter/material.dart';

IconData getIcon(String categoryType) {
  switch (categoryType) {
    case 'Food':
      return Icons.free_breakfast_sharp;
    case 'Utility':
      return Icons.settings;
    case 'Fashion':
      return Icons.umbrella;
    case 'Taxes':
      return Icons.money_outlined;
    case 'Rent':
      return Icons.other_houses;
    case 'Insurance':
      return Icons.insights_outlined;
    case 'Business':
      return Icons.business;
    case 'Job':
      return Icons.work_outline;
    case 'Other':
      return Icons.open_with_rounded;
  }
  return Icons.crop_free_sharp;
}
