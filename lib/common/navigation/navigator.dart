import 'package:flutter/material.dart';

class BasePageNavigator {
  static GlobalKey<NavigatorState> navigatorKey;

  static void push(RouteDefinition route) {
    if (route.arguments == null) {
      navigatorKey.currentState.push(MaterialPageRoute(builder: route.builder));
    } else {
      MaterialPageRoute _route = MaterialPageRoute(
          builder: route.builder, settings: RouteSettings(name: route.name, arguments: route.arguments));

      if (route.arguments.replaceCurrent) {
        navigatorKey.currentState.pushAndRemoveUntil(_route, (_) => false);
      } else {
        navigatorKey.currentState.push(_route);
      }
    }
  }
  static void pop(){
    navigatorKey.currentState.pop(); //FIXME: Pops to blank page
  }
}

class NavigationArguments {
  final bool showBottomBar;
  final int activeBottomBarItemIndex;
  final bool replaceCurrent;

  NavigationArguments({this.showBottomBar = true, this.activeBottomBarItemIndex = 0, this.replaceCurrent = false});
}

class RouteDefinition {
  final String name;
  final WidgetBuilder builder;
  final NavigationArguments arguments;

  RouteDefinition({this.name, this.builder, this.arguments});
}
