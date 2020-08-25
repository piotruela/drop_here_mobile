import 'package:drop_here_mobile/common/config/app_config.dart';
import 'package:drop_here_mobile/common/navigation/app_navigation_observer.dart';
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/ui/pages/first_page.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_scaffold.dart';

class MainWidget extends StatefulWidget {
  final AppConfig appConfig;
  final GlobalKey navigatorKey;

  const MainWidget({Key key, this.appConfig, this.navigatorKey}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  AppNavigationObserver navigatorObserver;
  final AppNavigationNotifier notifier = AppNavigationNotifier(NavigationArguments());

  @override
  void initState() {
    super.initState();
    BasePageNavigator.navigatorKey = widget.navigatorKey;
    navigatorObserver = AppNavigationObserver(widget.navigatorKey, notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initAsync());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => Localization.of(context).bundle.appTitle,
      navigatorKey: widget.navigatorKey,
      theme: widget.appConfig.themeConfig.primaryTheme(),
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LocalizationDelegate.supportedLocales,
      home: LoginPage(),//GreeterPage(),
      builder: (builderContext, child) {
        return AppInheritedNavigationNotifier(
          notifier: notifier,
          child: AppScaffold(
            child: child,
            navigatorKey: widget.navigatorKey,
          ),
        );
      },
      navigatorObservers: [navigatorObserver],
    );
  }


  Future<void> _initAsync() async {
  }
}
