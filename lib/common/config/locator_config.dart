import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_config.dart';
import 'assets_config.dart';

GetIt locator = GetIt.instance;

abstract class LocatorConfig {
  void registerObjects(AppConfig appConfig) {
    _registerAssets(appConfig);
    _registerTheme(appConfig);

  }


  void _registerAssets(AppConfig appConfig) {
    locator.registerSingleton<AssetsConfig>(appConfig.assetsConfig);
  }

  void _registerTheme(AppConfig appConfig) {
    locator.registerSingleton<ThemeConfig>(appConfig.themeConfig);
  }

  @protected
  void registerServices();
}
