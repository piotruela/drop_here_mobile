import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/sandbox_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/welcome_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 102.0),
                  child: Container(
                    height: 193,
                    width: 268,
                    child: SvgPicture.asset(assetsConfig.splashScreenImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0, bottom: 17.0),
                  child: Text(Localization.of(context).bundle.appTitle, style: themeConfig.textStyles.primaryTitle),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 67.0, right: 67.0),
                  child: Text(Localization.of(context).bundle.lorem,
                      style: themeConfig.textStyles.contentTitle, textAlign: TextAlign.center),
                ),
                Padding(
                    //TODO: Use DhButton padding
                    padding: const EdgeInsets.only(top: 55.0),
                    child: DhButton(
                      onPressed: () {
                        Get.to(WelcomePage());
                      },
                      text: Localization.of(context).bundle.getStarted,
                      backgroundColor: themeConfig.colors.primary1,
                    )),
                FlatButton(
                  child: Text('sandbox'),
                  onPressed: () {
                    Get.to(SandboxPage());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
