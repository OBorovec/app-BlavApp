import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final Map<int, String> dateTimeWeekDays = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};

String namedDateTime(DateTime dt) {
  return dateTimeWeekDays[dt.weekday] ?? 'Unknown';
}

String datetimeToHours(DateTime? dt, BuildContext context) {
  if (dt != null) {
    final String locale = Localizations.localeOf(context).languageCode;
    DateFormat timeFormat = DateFormat.Hm(locale);
    return timeFormat.format(dt);
  } else {
    return '---';
  }
}

String datetimeDayDate(DateTime? dt, BuildContext context) {
  if (dt != null) {
    final String locale = Localizations.localeOf(context).languageCode;
    DateFormat timeFormat = DateFormat('EEE dd/MM', locale);
    return timeFormat.format(dt);
  } else {
    return '---';
  }
}

String datetimeToDate(DateTime? dt, BuildContext context) {
  if (dt != null) {
    final String locale = Localizations.localeOf(context).languageCode;
    DateFormat timeFormat = DateFormat.MMMMd(locale);
    return timeFormat.format(dt);
  } else {
    return '---';
  }
}

String datetimeToDateShort(DateTime? dt, BuildContext context) {
  if (dt != null) {
    final String locale = Localizations.localeOf(context).languageCode;
    DateFormat timeFormat = DateFormat.MMMd(locale);
    return timeFormat.format(dt);
  } else {
    return '---';
  }
}

String formatTimeRange(DateTime start, DateTime? end) {
  if (end == null) {
    return formatDateYear(start);
  } else if (start.isAtSameMomentAs(end)) {
    return formatDateYear(start);
  } else {
    return '${formatDate(start)}-${formatDateYear(end)}';
  }
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM');
  return formatter.format(date);
}

String formatDateYear(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}
