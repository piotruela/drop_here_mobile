import 'package:drop_here_mobile/common/config/locator_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_text_form_field.dart';
import 'package:drop_here_mobile/counter/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';

class SellerDetailsRegistrationPage extends StatefulWidget {
  @override
  _SellerDetailsRegistrationPageState createState() =>
      _SellerDetailsRegistrationPageState();
}

class _SellerDetailsRegistrationPageState
    extends State<SellerDetailsRegistrationPage> {
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
                            .addDetailsAboutCompanyHeader,
                        style: themeConfig.textStyles.secondaryTitle),
                  ),
                  DhTextFormField(
                      labelText: Localization.of(context).bundle.companyName,
                      padding: EdgeInsets.only(
                          left: 40, right: 40.0, top: 26.0, bottom: 9.0)),
                  DhTextFormField(
                      labelText: Localization.of(context).bundle.countryName,
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
