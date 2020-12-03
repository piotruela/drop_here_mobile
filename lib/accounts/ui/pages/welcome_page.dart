import 'package:drop_here_mobile/accounts/ui/layout/main_layout.dart';
import 'package:drop_here_mobile/accounts/ui/pages/company_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/customer_registration_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/login_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_button.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/thresholds.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final AssetsConfig assetsConfig = Get.find<AssetsConfig>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    print(width);
    return MainLayout(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: width > Thresholds.width
                        ? const EdgeInsets.only(top: 100.0)
                        : const EdgeInsets.only(top: 80.0),
                    child: Text(Localization.of(context).bundle.welcomeOnBoard,
                        style: themeConfig.textStyles.secondaryTitle),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 67.0, right: 67.0, top: 13.0, bottom: 16.0),
                    child: Text(Localization.of(context).bundle.welcomeText,
                        style: themeConfig.textStyles.contentTitle, textAlign: TextAlign.center),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 40.0),
                          child: _sellerBuyerChoiceTile(() {
                            Get.to(CompanyRegistrationPage());
                          }, Localization.of(context).bundle.imASeller, assetsConfig.sellerImage,
                              width)),
                      _sellerBuyerChoiceTile(() {
                        Get.to(CustomerRegistrationPage());
                      }, Localization.of(context).bundle.imABuyer, assetsConfig.buyerImage, width)
                    ],
                  ),
                  Padding(
                    padding: width > Thresholds.width
                        ? const EdgeInsets.only(top: 100.0)
                        : const EdgeInsets.only(top: 35.0),
                    child: Text(
                      Localization.of(context).bundle.haveAnAccountQuestion,
                    ),
                  ),
                  DhButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    text: Localization.of(context).bundle.signIn,
                    backgroundColor: themeConfig.colors.primary1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _sellerBuyerChoiceTile(void Function() onTap, String text, String picturePath, double width) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0, bottom: 7),
              child: SizedBox(
                  height: width > Thresholds.width ? 159 : 100,
                  width: width > Thresholds.width ? 88 : 55,
                  child: SvgPicture.asset(picturePath)),
            ),
            Text(text, style: themeConfig.textStyles.secondaryTitle)
          ],
        ),
        height: width > Thresholds.width ? 202 : 150,
        width: width > Thresholds.width ? 155 : 115,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: themeConfig.colors.primary2),
      ),
    );
  }
}
