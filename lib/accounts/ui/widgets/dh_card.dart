import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dh_shadow.dart';

typedef OnItemSelected = Function(String);

class DhCard extends StatelessWidget {
  final String title;
  final MembershipStatus status;
  final int dropsNumber;
  final List<String> popupOptions;
  final EdgeInsets padding;
  final OnItemSelected onItemSelected;
  const DhCard(
      {this.title,
      this.status,
      this.dropsNumber,
      this.popupOptions,
      this.padding,
      this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
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
              statusText(locale, themeConfig, status),
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
            onSelected: (value) => onItemSelected(value),
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

  Widget statusText(LocaleBundle locale, ThemeConfig themeConfig, MembershipStatus status) {
    String text;
    IconData icon;
    Color color;
    switch (status) {
      case MembershipStatus.ACTIVE:
        text = locale.active;
        icon = Icons.check;
        color = themeConfig.colors.active;
        break;
      case MembershipStatus.PENDING:
        text = locale.pending;
        icon = Icons.hourglass_empty;
        color = themeConfig.colors.pending;
        break;
      case MembershipStatus.BLOCKED:
        text = locale.blocked;
        icon = Icons.close;
        color = themeConfig.colors.blocked;
        break;
    }
    return Row(
      children: [
        Text(
          text,
          style: themeConfig.textStyles.active.copyWith(color: color),
        ),
        Icon(
          icon,
          color: color,
        ),
      ],
    );
  }
}
