import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageDate {
  //formatta singola data
  static String formatDate(DateTime? date, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    String dayOfWeek = DateFormat.EEEE(locale).format(date!);
    String dayMonth = DateFormat.MMMMd(locale).format(date);
    String year = DateFormat.y(locale).format(date);
    return "$dayOfWeek $dayMonth $year";
  }

  // formatta range di date
  String formatDateRange(DateTimeRange range, BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    // start date
    String dayOfWeekStart = DateFormat.EEEE(locale).format(range.start);
    String dayMonthStart = DateFormat.MMMMd(locale).format(range.start);
    String yearStart = DateFormat.y(locale).format(range.start);
    // end date
    String dayOfWeekEnd = DateFormat.EEEE(locale).format(range.end);
    String dayMonthEnd = DateFormat.MMMMd(locale).format(range.end);
    String yearEnd = DateFormat.y(locale).format(range.end);

    String dal = "$dayOfWeekStart\\$dayMonthStart\\$yearStart";
    String al = "$dayOfWeekEnd\\$dayMonthEnd\\$yearEnd";
    return "DAL $dal AL $al";
  }
}
