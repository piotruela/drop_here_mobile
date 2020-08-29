import 'package:drop_here_mobile/config/drop_here_locator_config.dart';
import 'package:flutter/material.dart';

import 'common/config/app_config.dart';
import 'common/config/locator_config.dart';
import 'common/ui/widgets/main_widget.dart';


void startApp(AppConfig appConfig) async {
  LocatorConfig locatorConfig = AppLocatorConfig();
  locatorConfig.registerObjects(appConfig);

  runApp(MainWidget(
    appConfig: appConfig,
    navigatorKey: GlobalKey<NavigatorState>(),
  ));
}
