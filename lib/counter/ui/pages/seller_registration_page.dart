import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class SellerRegistrationPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();

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
                  child: Text(Localization.of(context).bundle.createASellerAccountHeader, style: themeConfig.textStyles.secondaryTitle),
                ),
                DhTextFormField(labelText: Localization.of(context).bundle.email, padding: EdgeInsets.only(left: 40, right: 40.0, top: 13.0, bottom: 9.0),),
                DhTextFormField(labelText: Localization.of(context).bundle.password, padding: EdgeInsets.only(left: 40, right: 40.0, top: 13.0, bottom: 9.0)),
                DhTextFormField(labelText: Localization.of(context).bundle.repeatPassword, padding: EdgeInsets.only(left: 40,
                    right: 40.0, top: 13.0, bottom: 9.0)),
                Padding(
                  padding: const EdgeInsets.only(top:132.0, bottom: 11.0),
                  child: DhButton(onPressed: () {}, text: Localization.of(context).bundle.signUp, backgroundColor:
                  themeConfig.colors.primary1,),
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 6.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Text(Localization.of(context).bundle.haveAnAccountQuestion, style: themeConfig.textStyles.contentTitle)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
