import 'package:drop_here_mobile/accounts/ui/pages/add_product_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_route_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/add_spot_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_profile_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CreateNewItemPage extends StatelessWidget {
  final PanelController controller;
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  CreateNewItemPage({this.controller});

  @override
  Widget build(BuildContext context) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    locale.addNew,
                    style: themeConfig.textStyles.primaryTitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, bottom: 10.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () => controller.close(),
                          icon: Icon(Icons.close, size: 40.0))),
                )
              ],
            ),
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
              cardButton(() => Get.to(AddRoutePage()), locale.route, Icons.map),
              cardButton(() => Get.to(CreateRegularProfilePage()), locale.profile, Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardButton(VoidCallback onTap, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
