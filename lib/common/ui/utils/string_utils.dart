import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isEmpty(String string) => (string == null || string.isEmpty);

bool isNotEmpty(String string) => (string != null && string.isNotEmpty);

String reverse(String s) => String.fromCharCodes(s.runes.toList().reversed);

String removeLastCharacter(String string) {
  if (isEmpty(string)) {
    return string;
  }
  return substring(string, 0, string.length - 1);
}

String substring(String string, int start, [int end]) {
  //this has to recalculated because of the possible difference in byte length of runes vs string
  final endDif = string.length - (end ?? string.length);
  final runes = string.runes.toList();
  return String.fromCharCodes(runes.sublist(start, runes.length - endDif));
}

String removeFirstCharacter(String string) {
  if (isEmpty(string)) {
    return string;
  }
  return substring(string, 1, string.length);
}

String capitalize(String string) =>
    isNotEmpty(string) ? string[0].toUpperCase() + string.substring(1) : string;

bool isDigit(String string) {
  if (string == null || string.length != 1) {
    return false;
  }

  return int.tryParse(string) != null;
}

String describeEnum(Object enumEntry) {
  final String description = enumEntry.toString();
  final int indexOfDot = description.indexOf('.');
  assert(indexOfDot != -1 && indexOfDot < description.length - 1);
  return description.substring(indexOfDot + 1);
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}
