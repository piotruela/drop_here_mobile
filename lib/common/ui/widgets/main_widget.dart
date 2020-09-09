import 'package:drop_here_mobile/common/config/config_binding.dart';
import 'package:drop_here_mobile/counter/login_pages.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';


class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ConfigBinding(),
      initialRoute: '/splash',
      defaultTransition: Transition.native,
      onGenerateTitle: (BuildContext context) => Localization.of(context).bundle.appTitle,
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LocalizationDelegate.supportedLocales,
      getPages: LoginPages.pages,
    );
  }
}

