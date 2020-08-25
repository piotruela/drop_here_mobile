
import 'package:flutter/material.dart';

import '../common_types.dart';

class BottomBarItem {
  final Widget icon;
  final StringGetter text;
  final VoidCallbackWithContext navigate;

  BottomBarItem({@required this.icon,@required this.text, @required this.navigate});
}
