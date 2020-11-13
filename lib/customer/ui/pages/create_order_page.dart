import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/icon_in_circle.dart';
import 'package:drop_here_mobile/customer/bloc/create_order_bloc.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/model/order_product_model.dart';
import 'package:drop_here_mobile/products/ui/widgets/product_card.dart';
import 'package:drop_here_mobile/shipments/ui/pages/add_products_to_order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CreateOrderPage extends BlocWidget<CreateOrderBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();

  @override
  bloc() => CreateOrderBloc();

  @override
  Widget build(BuildContext context, CreateOrderBloc createOrderBloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => _buildPageContent(context, createOrderBloc)),
    );
  }

  SafeArea _buildPageContent(BuildContext context, CreateOrderBloc bloc) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.placeOrder,
                style: themeConfig.textStyles.primaryTitle,
              ),
              SizedBox(height: 19.0),
              Text(
                locale.productsMandatory,
                style: themeConfig.textStyles.secondaryTitle,
              ),
              productsCarousel(context, bloc),
            ],
          ),
        ),
      ],
    ));
  }

  CarouselSlider productsCarousel(BuildContext context, CreateOrderBloc bloc) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.38,
          initialPage: 0,
        ),
        items: [
          for (OrderProductModel product in bloc.state.products ?? [])
            OrderProductCard(
              locale: locale,
              product: product,
            ),
          GestureDetector(
            onTap: () async {
              bloc.add(AddProducts(
                  products: await Get.to(AddProductsToOrderPage(bloc.state.products.toSet()))));
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: IconInCircle(
              themeConfig: themeConfig,
              icon: Icons.add,
            ),
          )
        ]

        //
        //     for (LocalProduct product in bloc.state.products ?? [])
        // productCard(
        //   locale: locale,
        //   product: product,
        // ),

        //products.map((product) => ItemCard(product: product)).toList(),
        );
  }
}
