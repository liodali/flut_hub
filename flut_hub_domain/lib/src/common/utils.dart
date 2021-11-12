import 'package:intl/intl.dart';

import '../../flut_hub_domain.dart';

extension MoreExt on List<InnerQuery> {
  /// [toInnerString]
  /// this method transform list of [InnerQuery] to String that match
  /// with query input of github rest api.
  /// return String that will be add it to query name in http call to get data from github rest api
  String toInnerString() {
    return map((e) => e.toString()).reduce((elem1, elem2) => "$elem1+$elem2");
  }
}

final format = DateFormat("yyyy-MM-dd\Thh:mm:ss\Z");

/// [formatTo]
/// this method used to format DateTime to String from specific format yyyy-MM-ddThh:mm:ssZ
/// return String value that represent format value of dateTime
/// throw formatException if format contain undefined symbols
String formatTo(DateTime createAt) {
  return format.format(createAt);
}

/// [parseTo]
/// this method used to parse String to  DateTime of  specific format yyyy-MM-ddThh:mm:ssZ
/// return DateTime value that represent parse  value of String
/// throw formatException if format contain undefined symbols
DateTime parseTo(String createAt) {
  return format.parse(createAt);
}

/// [differenceDaysFromNow]
/// this method calculate difference inDays between now and date
/// date should be before
/// return String that represent number of days or weeks or months
/// return 0d when now is before [date] parameter
String differenceDaysFromNow(DateTime date) {
  final now = DateTime.now();
  if (now.isBefore(date)) {
    return "0d";
  }
  int days = now.difference(date).inDays;
  if (days > 0) {
    if (days ~/ 30 > 0) {
      return "${(days / 30).round()}mo";
    }
    if (days ~/ 7 > 0) {
      return "${days ~/ 7}w";
    }
    return "${days}d";
  }
  return DateFormat("HH:mm").format(date);
}
