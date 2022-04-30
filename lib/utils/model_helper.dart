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
