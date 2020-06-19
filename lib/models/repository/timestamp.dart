import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

/// Save data about time and date.
class Timestamp {
  String year;
  String month;
  String day;
  String hour;
  String minute;
  String second;

  Timestamp({@required DateTime dateTime}) {
    year = DateFormat.y().format(dateTime);
    month = DateFormat.M().format(dateTime);
    day = DateFormat.d().format(dateTime);
    hour = DateFormat.H().format(dateTime);
    minute = DateFormat.m().format(dateTime);
    second = DateFormat.s().format(dateTime);
  }

  @override
  String toString() {
    return year +
        "-" +
        month +
        "-" +
        day +
        " " +
        hour +
        ":" +
        minute +
        ":" +
        day;
  }
}
