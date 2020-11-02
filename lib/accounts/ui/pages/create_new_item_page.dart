import 'package:drop_here_mobile/accounts/ui/pages/add_product_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_spot_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewItemPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                locale.addNew,
                style: themeConfig.textStyles.primaryTitle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 8.0,
                crossAxisCount: 2,
              ),
              children: [
                cardButton(() => Get.to(AddProductPage()), locale.product, Icons.shopping_basket),
                cardButton(() => Get.to(AddSpotPage()), locale.spot, Icons.store),
              ],
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 8.0,
                crossAxisCount: 2,
              ),
              children: [
                cardButton(() => {}, locale.route, Icons.map),
                cardButton(() => Get.to(CreateRegularProfilePage()), locale.profile, Icons.person),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding cardButton(VoidCallback onTap, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 100.0,
                color: themeConfig.colors.primary1,
              ),
              Text(
                text,
                style: themeConfig.textStyles.secondaryTitle,
              )
            ],
          ),
          decoration: BoxDecoration(
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }
}
