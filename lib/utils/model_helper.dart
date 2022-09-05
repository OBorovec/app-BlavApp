import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';

bool isOpenCal(Map<String, String> open) {
  final String openFrom = open['from']!;
  final String openTo = open['to']!;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final DateTime openAt =
      DateTime.parse("${dateFormat.format(DateTime.now())} $openFrom");
  final DateTime closeAt =
      DateTime.parse("${dateFormat.format(DateTime.now())} $openTo");
  return DateTime.now().isAfter(openAt) && DateTime.now().isBefore(closeAt);
}

// Converts input string to a unique 32-bit integer
int stringIdToIntId(String stringId) {
  List<int> ints = utf8.encode(stringId);
  double notificationId = 0;
  for (int i = 0; i < ints.length; i++) {
    notificationId += ints[i] * pow(10, i);
  }
  // Convert to 32-bit integer
  return (notificationId % 2147483647).toInt();
}
