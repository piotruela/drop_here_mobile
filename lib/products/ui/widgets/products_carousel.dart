import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_shadow.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/bloc/product_card_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CarouselSlider productsCarousel(LocaleBundle locale, List<RouteProductRouteResponse> products) {
  return CarouselSlider(
    options: CarouselOptions(
      aspectRatio: 14 / 7.4,
      enableInfiniteScroll: false,
      viewportFraction: 0.38,
      initialPage: 0,
    ),
    items: products.map((product) => ProductCard(product: product)).toList(),
  );
}

class ProductCard extends BlocWidget<ProductCardBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  final RouteProductRouteResponse product;

  ProductCard({this.product});

  @override
  ProductCardBloc bloc() => ProductCardBloc()..add(FetchProductPhoto(product.id));

  @override
  Widget build(BuildContext context, ProductCardBloc bloc, _) {
    LocaleBundle locale = Localization.of(context).bundle;
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 154,
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                child: ClipOval(child: Icon(Icons.shopping_basket_outlined)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    product.productResponse.name,
                    style: themeConfig.textStyles.title3,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product.toPricePerUnit(locale),
                    style: themeConfig.textStyles.title3Annotation,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    product.limitedAmount == null || product.limitedAmount == false
                        ? locale.unlimited
                        : product.amount.toString() + product.productResponse.unit,
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
}
