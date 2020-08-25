import 'package:drop_here_mobile/config/drop_here_locator_config.dart';
import 'package:flutter/material.dart';

import 'common/config/app_config.dart';
import 'common/config/bottom_bar_config.dart';
import 'common/config/locator_config.dart';
import 'common/ui/widgets/main_widget.dart';
import 'config/drop_here_bottom_bar_config.dart';


void startApp(AppConfig appConfig) async {
  locator.registerSingleton<BottomBarConfig>(DHBottomBarConfig());

  runApp(MainWidget(
    appConfig: appConfig,
    navigatorKey: GlobalKey<NavigatorState>(),
  ));
}
