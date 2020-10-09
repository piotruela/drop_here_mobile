import 'dart:io';

import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final double price;
  final String unit;
  final List<String> popupOptions;
  final File photo;

  const ProductCard(
      {this.title, this.category, this.price, this.unit, this.popupOptions, this.photo});

  @override
  //TODO add shadow and change dots icon
  Widget build(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final LocaleBundle locale = Localization.of(context).bundle;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7.0),
      child: Card(
        child: ListTile(
          leading: productPhoto(context),
          title: Text(
            title,
            style: themeConfig.textStyles.secondaryTitle,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Text(
                locale.category + ': ' + category,
                style: themeConfig.textStyles.cardSubtitle,
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                locale.price + ': ' + price.toString() + locale.currency + '/' + unit,
                style: themeConfig.textStyles.cardSubtitle,
              ),
              //Text(locale.price + ':' + price.toString() + '' + unit),
            ],
          ),
          trailing: PopupMenuButton<String>(
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
      ),
    );
  }

  Widget productPhoto(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 44,
          minHeight: 44,
          maxWidth: 84,
          maxHeight: 84,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.file(photo, fit: BoxFit.cover)));
  }
}
