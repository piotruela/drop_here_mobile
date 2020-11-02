import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class SellerCard extends StatelessWidget {
  final String title;
  final List<String> popupOptions;
  const SellerCard({this.title, this.popupOptions});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Container(
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
          ),
          title: Text(
            title,
            style: themeConfig.textStyles.secondaryTitle,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
          trailing: PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: themeConfig.colors.black,
              size: 30.0,
            ),
            onSelected: (_) {},
            itemBuilder: (BuildContext context) {
              return popupOptions.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: themeConfig.textStyles.popupMenu,
                  ),
                );
              }).toList();
            },
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
    );
  }
}
