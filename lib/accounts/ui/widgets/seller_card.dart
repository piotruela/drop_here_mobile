import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class SellerCard extends StatelessWidget {
  final String title;
  final List<String> popupOptions;
  final Icon trailing;
  final Function onTap;
  final bool selected;
  const SellerCard({this.title, this.popupOptions, this.trailing, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 40.0,
              ),
            ),
            title: Text(
              title,
              style: themeConfig.textStyles.secondaryTitle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
            trailing: trailing,
          ),
          decoration: BoxDecoration(
            border: selected ? Border.all(width: 2.0, color: themeConfig.colors.primary1) : null,
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
