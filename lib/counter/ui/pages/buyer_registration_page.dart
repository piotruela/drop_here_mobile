import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/counter/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_text_button.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';

class BuyerRegistrationPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:100.0, bottom: 10.0),
                    child: Text(Localization.of(context).bundle.createABuyerAccount, style: themeConfig.textStyles
                        .secondaryTitle),
                  ),
                  DhTextFormField(labelText: Localization.of(context).bundle.email),
                  DhTextFormField(labelText: Localization.of(context).bundle.password),
                  DhTextFormField(labelText: Localization.of(context).bundle.repeatPassword),
                  DhButton(onPressed: () {}, text: Localization.of(context).bundle.signUp, backgroundColor:
                  themeConfig.colors.primary1,),
                  Text(Localization.of(context).bundle.or, style: themeConfig.textStyles.secondaryTitle),
                  DhButton(onPressed: () {}, text: Localization.of(context).bundle.signUpWithFacebook, backgroundColor:
                  themeConfig.colors.facebookColor,),

                  DhTextButton(text: Localization.of(context).bundle.haveAnAccountQuestion, onTap: () => Get.to
                    (LoginPage
                    ())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
