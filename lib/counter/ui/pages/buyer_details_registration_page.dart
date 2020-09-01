import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class BuyerDetailsRegistrationPage extends StatelessWidget {
  final ThemeConfig themeConfig = locator.get<ThemeConfig>();
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
                    padding: const EdgeInsets.only(top: 144.0, bottom: 22.0),
                    child: Text(
                        Localization.of(context)
                            .bundle
                            .addDetailsAboutBuyerHeader,
                        style: themeConfig.textStyles.secondaryTitle),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 110.0,
                        height: 110.0,
                      ),
                      CircleAvatar(
                        backgroundColor: themeConfig.colors.primary1,
                        radius: 50.0,
                        child: Icon(
                          Icons.person,
                          color: themeConfig.colors.background,
                          size: 60.0,
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: CircleAvatar(
                          radius: 20.0,
                          backgroundColor: themeConfig.colors.secondary,
                          child: CircleAvatar(
                            backgroundColor: themeConfig.colors.primary1,
                            radius: 18.0,
                            child: Icon(
                              Icons.edit,
                              color: themeConfig.colors.background,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  DhTextFormField(
                      labelText: Localization.of(context).bundle.firstName,
                      padding: EdgeInsets.only(
                          left: 40, right: 40.0, top: 26.0, bottom: 9.0)),
                  DhTextFormField(
                      labelText: Localization.of(context).bundle.lastName,
                      padding: EdgeInsets.only(
                          left: 40, right: 40.0, top: 13.0, bottom: 20.0)),
                  DhButton(
                    onPressed: () {},
                    text: Localization.of(context).bundle.continueText,
                    backgroundColor: themeConfig.colors.primary1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
