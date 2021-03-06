import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/config/config_binding.dart';
import 'package:drop_here_mobile/common/pages.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) =>
          MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child),
      initialBinding: ConfigBinding(),
      initialRoute: '/splash',
      onInit: () {
        _initialize();
      },
      defaultTransition: Transition.native,
      onGenerateTitle: (BuildContext context) => Localization.of(context).bundle.appTitle,
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LocalizationDelegate.supportedLocales,
      getPages: Pages.pages,
    );
  }

  _initialize() async {
    await Get.find<AppStorageService>().init();
  }
}
