import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return (Scaffold(
      body: SafeArea(
        child: ListView(
          children: [Text('abc')],
        ),
      ),
    ));
  }
}
