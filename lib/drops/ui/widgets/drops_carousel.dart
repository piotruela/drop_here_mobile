import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

CarouselSlider dropsCarousel(List<DropRouteResponse> drops) {
  return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 7.4,
        enableInfiniteScroll: false,
        viewportFraction: 0.5,
        initialPage: 0,
      ),
      items: drops.map((item) => mapCard(item)).toList());
}

Widget mapCard(DropRouteResponse drop, {File photo}) {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  return Padding(
    padding: const EdgeInsets.only(right: 22.0, bottom: 6.0),
    child: Container(
      decoration: BoxDecoration(
        color: themeConfig.colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          dhShadow(),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 154,
            height: 96,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: photo != null
                  ? Image.file(
                      photo,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.map,
                      size: 60,
                      color: themeConfig.colors.primary1,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drop.name,
                  style: themeConfig.textStyles.title3,
                ),
                SizedBox(height: 4.0),
                Text(
                  DateFormat('EEEE').format(drop.startTime) +
                      ', ' +
                      DateFormat.Hm().format(drop.startTime) +
                      ' - ' +
                      DateFormat.Hm().format(drop.endTime),
                  style: themeConfig.textStyles.title3Annotation,
                ),
                SizedBox(height: 6.0),
                Text(
                  drop.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: themeConfig.textStyles.title3Annotation,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
