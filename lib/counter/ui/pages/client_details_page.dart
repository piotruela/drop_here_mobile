import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_list_tile.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeConfig.colors.primary1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 14.0),
            child: Text(
              Localization.of(context).bundle.yourDetails,
              style: themeConfig.textStyles.secondaryTitle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            color: themeConfig.colors.primary1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 27.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.withOpacity(0.25), spreadRadius: 5)],
                        ),
                        child: CircleAvatar(
                          radius: 64.0,
                          child: ClipOval(
                            child: CircleAvatar(
                              backgroundColor: themeConfig.colors.white,
                              radius: 64.0,
                              child: Icon(
                                Icons.person,
                                color: themeConfig.colors.primary1,
                                size: 110.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: InkWell(
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: themeConfig.colors.secondary,
                            child: CircleAvatar(
                              backgroundColor: themeConfig.colors.white,
                              radius: 18.0,
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DhListTile(
            themeConfig: themeConfig,
            icon: Icons.person,
            title: Localization.of(context).bundle.firstName,
            trailing: "Piotr",
          ),
          DhListTile(
            themeConfig: themeConfig,
            icon: Icons.person,
            title: Localization.of(context).bundle.lastName,
            trailing: "Maszota",
          ),
          DhListTile(
            themeConfig: themeConfig,
            icon: Icons.email,
            title: Localization.of(context).bundle.email,
            trailing: "hotTeen@gmail.com",
          ),
        ],
      ),
    );
  }
}
