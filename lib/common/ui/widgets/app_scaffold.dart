import 'package:drop_here_mobile/common/config/bottom_bar_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/config/drop_here_bottom_bar_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bottom_bar.dart';


class AppScaffold extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const AppScaffold({Key key, this.child, @required this.navigatorKey}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomBar(),
    );
  }
}
