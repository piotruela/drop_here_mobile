import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Formatting on DateTime {
  String toTime() {
    return DateFormat.Hm().format(this);
  }

  String toStringWithoutTime() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toStringWithTime() {
    return DateFormat('yyyy-MM-dd, HH:mm').format(this);
  }

  String toStringWithoutYear() => DateFormat('dd.MM, HH:mm').format(this);
}

extension Format on TimeOfDay {
  String toStringWithoutSeconds(BuildContext context) => this.format(context);

  double toDouble() => this.hour + this.minute / 60.0;

  bool isAfter(TimeOfDay another) => this.toDouble() > another.toDouble();

  TimeOfDay fromString(String time) =>
      TimeOfDay(hour: int.parse(time.substring(0, 1)), minute: int.parse(time.substring(3, 4)));
}

extension Transform on String {
  TimeOfDay get toTimeOfDay =>
      TimeOfDay(hour: int.parse(this.substring(0, 2)), minute: int.parse(this.substring(3, 5)));

  DateTime get toDateTime => DateTime.parse(this);
}
