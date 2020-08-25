import 'package:drop_here_mobile/common/common_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef WidgetGetter = Widget Function(BuildContext);

class TabItem {
  final StringGetter title;
  final WidgetGetter content;

  const TabItem({@required this.title, @required this.content});
}
