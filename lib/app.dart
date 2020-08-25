import 'package:flutter/material.dart';

import 'common/config/app_config.dart';
import 'common/ui/widgets/main_widget.dart';



void startApp(AppConfig appConfig) async {


  runApp(MainWidget(
    appConfig: appConfig,
    navigatorKey: GlobalKey<NavigatorState>(),
  ));
}
