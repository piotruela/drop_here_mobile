import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/products/ui/pages/product_details_page.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CarouselSlider productsCarousel(LocaleBundle locale, List<RouteProductRouteResponse> products) {
  return CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 14 / 6.4,
      enableInfiniteScroll: false,
      viewportFraction: 0.4,
      initialPage: 0,
    ),
    items: products?.map((product) => RouteDetailsProductCard(product: product))?.toList(),
  );
}

class RouteDetailsProductCard extends NarrowTile {
  final RouteProductRouteResponse product;

  RouteDetailsProductCard({this.product});

  @override
  String get firstLineText => product.pricePerUnit;

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => product.productAmountToString;

  @override
  String get tileTitle => product.routeProductResponse.name;

  @override
  get tileClickedAction => () => Get.to(ProductDetailsPage(
        product: product.routeProductResponse,
        editable: false,
      ));
}
