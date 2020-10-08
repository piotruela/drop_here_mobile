import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

class DhCard extends StatelessWidget {
  final String title;
  final bool isActive;
  final int dropsNumber;
  final List<String> popupOptions;
  const DhCard({this.title, this.isActive, this.dropsNumber, this.popupOptions});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
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
            children: [
              statusText(locale, themeConfig, isActive),
              Text(
                dropsNumber != null
                    ? locale.memberOf + ' ' + dropsNumber.toString() + ' ' + locale.spots
                    : '',
                style: themeConfig.textStyles.cardSubtitle,
              )
            ],
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

  Row statusText(LocaleBundle locale, ThemeConfig themeConfig, bool isActive) {
    if (isActive) {
      return Row(
        children: [
          Text(
            locale.active,
            style: themeConfig.textStyles.active,
          ),
          Icon(
            Icons.check,
            color: themeConfig.colors.active,
          ),
        ],
      );
    }
    return Row(
      children: [
        Text(
          locale.blocked,
          style: themeConfig.textStyles.blocked,
        ),
        Icon(
          Icons.clear,
          color: themeConfig.colors.blocked,
        ),
      ],
    );
  }
}
