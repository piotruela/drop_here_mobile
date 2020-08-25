import 'package:flutter/widgets.dart';

import 'navigator.dart';

class AppInheritedNavigationNotifier extends InheritedNotifier<AppNavigationNotifier> {
  @override
  final AppNavigationNotifier notifier;

  const AppInheritedNavigationNotifier({
    Key key,
    @required this.notifier,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedNotifier<AppNavigationNotifier> oldWidget) {
    return oldWidget.notifier.value != notifier.value;
  }

  static AppInheritedNavigationNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppInheritedNavigationNotifier>();
  }
}

class AppNavigationNotifier extends ValueNotifier<NavigationArguments> {
  AppNavigationNotifier(NavigationArguments value) : super(value);

//  void notifyWith({@required StringGetter newPageTitle}) {
//    value = value.copyWith(topBarArguments: TopBarArgs.text(newPageTitle));
//  }
}

class AppNavigationObserver extends NavigatorObserver {
  final AppNavigationNotifier navigationNotifier;

  final GlobalKey<NavigatorState> navigatorKey;

//  final _processLikeNavigationHandler = _ProcessLikeNavigationHandler();

  AppNavigationObserver(this.navigatorKey, this.navigationNotifier);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
//    _copyBottomBarItemIfNotProvided(previousRoute, route);
//    _processLikeNavigationHandler.handle(previousRoute, route);
    _maybeNotify(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _maybeNotify(previousRoute);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
//    _copyBottomBarItemIfNotProvided(oldRoute, newRoute);
//    _processLikeNavigationHandler.handle(oldRoute, newRoute);
    _maybeNotify(newRoute);
  }

  ///this method copies the bottomBarItem that NavigationArguments might have in order to allow
  ///navigations like Home(homeItem) =push> ProductCard(homeItem) =push> Inbox(inboxItem) =pop> ProductCard(homeItem)
  ///to preserve the state of the active item in the bottom bar
//  void _copyBottomBarItemIfNotProvided(Route previousRoute, Route route) {
//    final routeArguments = route.settings.arguments;
//    final previousRouteArguments = previousRoute?.settings?.arguments;
//
//    if (routeArguments is NavigationArguments && previousRouteArguments is NavigationArguments) {
//      routeArguments.bottomBarItem ??= previousRouteArguments?.bottomBarItem;
//    }
//  }

  void _maybeNotify(Route<dynamic> newRoute) {
    final arguments = newRoute.settings.arguments;
    if (arguments is NavigationArguments) {
      navigationNotifier.value = arguments;
    }
  }
}

//class _ProcessLikeNavigationHandler {
//  void handle(Route previousRoute, Route route) {
//    final routeArguments = route.settings.arguments;
//
//    if (routeArguments is NavigationArguments) {
//      final processNavArgs = routeArguments.topBarArgs?.processNavigationArguments;
//      if (processNavArgs != null) {
//        //note: the originalRoute and initialProcessRoute is a mutableField
//        _updateProcessArgs(processNavArgs, previousRoute);
//      }
//    }
//  }
//
//  void _updateProcessArgs(ProcessNavigationArguments processNavArgs, Route previousRoute) {
//    final ProcessNavigationArguments previousRouteProcessArgs =
//        (previousRoute?.settings?.arguments as NavigationArguments)
//            ?.topBarArgs
//            ?.processNavigationArguments;
//    if (previousRouteProcessArgs == null) {
//      // This is first route in a process
//      processNavArgs.isOriginalProcessRoute = true;
//      processNavArgs.originalRoute = previousRoute;
//    } else {
//      // Subsequent route in a process
//      processNavArgs.isOriginalProcessRoute = false;
//      processNavArgs.originalRoute = previousRouteProcessArgs.originalRoute;
//    }
//  }
//}
