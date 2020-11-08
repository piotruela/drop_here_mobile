import 'package:intl/intl.dart';

extension Formatting on DateTime {
  String toTime() {
    return DateFormat.Hm().format(this);
  }
}
