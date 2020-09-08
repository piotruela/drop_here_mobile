import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/navigation/navigator.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/counter/counter_routes.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  final AssetsConfig assetsConfig = locator.get<AssetsConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 172.0),
              child: Container(
                height: 120,
                child: SvgPicture.asset(assetsConfig.splashScreenImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 19.0, bottom: 17.0),
              child: Text(Localization.of(context).bundle.appTitle,
                  style: themeConfig.textStyles.primaryTitle),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 67.0, right: 67.0),
              child: Text(Localization.of(context).bundle.lorem,
                  style: themeConfig.textStyles.contentTitle,
                  textAlign: TextAlign.center),
            ),
            Padding(
                //TODO: Use DhButton padding
                padding: const EdgeInsets.only(top: 55.0),
                child: DhButton(
                  onPressed: () {
                    BasePageNavigator.push(CounterRoutes.welcome);
                  },
                  text: Localization.of(context).bundle.getStarted,
                  backgroundColor: themeConfig.colors.primary1,
                )),
            FlatButton(
              onPressed: () {
                BasePageNavigator.push(CounterRoutes.sandbox);
              },
              child: Text(
                "sandbox",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
