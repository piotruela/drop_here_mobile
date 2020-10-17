import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpotCard extends StatelessWidget {
  final SpotCompanyResponse spot;
  final VoidCallback onTap;

  SpotCard({this.spot, this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: ListTile(
            leading: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.store,
            ),
            title: Text(
              spot.name,
              style: themeConfig.textStyles.secondaryTitle,
            ),
            subtitle: Text(
              "No scheduled drops",
              style: themeConfig.textStyles.cardSubtitle,
            ),
          ),
          decoration: BoxDecoration(
            color: themeConfig.colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              dhShadow(),
            ],
          ),
        ),
      ),
    );
  }
}
