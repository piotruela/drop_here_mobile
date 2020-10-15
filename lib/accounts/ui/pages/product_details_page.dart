import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/model/api/product_management_api.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/full_width_photo.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductDetailsPage extends StatelessWidget {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  //TODO add final
  Product product;
  final File photo;

  ProductDetailsPage({this.product, this.photo});

  @override
  Widget build(BuildContext context) {
    //TODO delete product
    product = Product();
    product.name = 'abc';
    product.unitFraction = 0.5;
    product.unit = "kilogram";
    product.description = "description";
    product.price = 5;
    product.category = "fruits";

    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        body: SlidingUpPanel(
      panel: buildColumnWithData(locale, context),
      //TODO change body
      body: Center(child: Text('background')),
    ));
  }

  SafeArea buildColumnWithData(LocaleBundle locale, BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          productTitle(),
          productSubtitle(),
          fullWidthPhoto(context, photo),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                descriptionAndData(locale, locale.description, product.description),
                descriptionAndData(locale, locale.unitType, product.unit),
                descriptionAndData(locale, locale.pricePerUnit, product.price.toString()),
                descriptionAndData(locale, locale.unitFraction, product.unitFraction.toString()),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 12.0),
                  child: Text(
                    locale.availableInDrops,
                    style: themeConfig.textStyles.title2,
                  ),
                ),
                carousel(),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CarouselSlider carousel() {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.5,
          initialPage: 0,
        ),
        items: [mapCard(), mapCard(), mapCard()]);
  }

  Padding productSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 2.0),
      child: Text(
        product.category,
        style: themeConfig.textStyles.category,
      ),
    );
  }

  Padding productTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 19.0, top: 10.0),
      child: Text(
        product.name,
        style: themeConfig.textStyles.primaryTitle,
      ),
    );
  }

  Widget mapCard() {
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
                child: Image.file(
                  photo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Drop No. 2',
                    style: themeConfig.textStyles.title3,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Monaday, 8 am - 1pm',
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'Available: 30kg',
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  //SizedBox(height: 5.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column descriptionAndData(LocaleBundle locale, String description, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 9.0,
        ),
        Text(
          description,
          style: themeConfig.textStyles.dataAnnotation,
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          data,
          style: themeConfig.textStyles.data,
        ),
      ],
    );
  }
}
