import 'package:drop_here_mobile/common/config/app_config.dart';
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/counter/ui/pages/splash_page.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_scaffold.dart';

class MainWidget extends StatefulWidget {
  final AppConfig appConfig;
  final GlobalKey navigatorKey;

  const MainWidget({Key key, this.appConfig, this.navigatorKey})
      : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
    BasePageNavigator.navigatorKey = widget.navigatorKey;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          Localization.of(context).bundle.appTitle,
      navigatorKey: widget.navigatorKey,
      theme: widget.appConfig.themeConfig.primaryTheme(),
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LocalizationDelegate.supportedLocales,
      home: SplashPage(),
      builder: (builderContext, child) {
        return AppScaffold(
          child: child,
          navigatorKey: widget.navigatorKey,
        );
      },
    );
  }
}
