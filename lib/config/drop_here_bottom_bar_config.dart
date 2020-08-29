import 'package:drop_here_mobile/common/config/bottom_bar_config.dart';
import 'package:drop_here_mobile/common/model/bottom_bar_item.dart';
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/counter_routes.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class DHBottomBarConfig extends BottomBarConfig {
  @override
  List<BottomBarItem> get tabBarItems => [
    BottomBarItem(
        icon: Icon(Icons.message),
        text: (context) => Localization.of(context).bundle.greetPageNavBarText,
        navigate: (context) => BasePageNavigator.push(CounterRoutes.login)),
    BottomBarItem(
        icon: Icon(Icons.info),
        text: (context) => Localization.of(context).bundle.infoPageNavBarText,
        navigate: (context) => BasePageNavigator.push(CounterRoutes.info)),
  ];
}
