import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
  final AssetsConfig assetsConfig = locator.get<AssetsConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:144.0),
                  child: Text(Localization.of(context).bundle.loginPageHeader, style: themeConfig.textStyles.secondaryTitle),
                ),
                DhTextFormField(labelText: Localization.of(context).bundle.email, padding: EdgeInsets.only(left: 40, right: 40.0, top: 13.0, bottom: 9.0),),
                DhTextFormField(labelText: Localization.of(context).bundle.password, padding: EdgeInsets.only(left: 40, right: 40.0, top: 13.0, bottom: 9.0)),
                Padding(
                  padding: const EdgeInsets.only( bottom: 6.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(Localization.of(context).bundle.forgotPasswordQuestion, style: themeConfig.textStyles.contentTitle)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:32.0, bottom: 20.0),
                  child: DhButton(onPressed: () {}, text: Localization.of(context).bundle.logIn, backgroundColor: themeConfig.colors.primary1,),
                ),
                Text(Localization.of(context).bundle.or, style: themeConfig.textStyles.secondaryTitle),
                Padding(
                  padding: const EdgeInsets.only(top:26.0, bottom: 11.0),
                  child: DhButton(onPressed: () {}, text: Localization.of(context).bundle.logInWithFacebook, backgroundColor: themeConfig.colors.facebookColor,),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
