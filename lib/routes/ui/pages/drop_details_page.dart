import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/big_colored_rounded_flat_button.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/utils/datetime_utils.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/labeled_circled_info.dart';
import 'package:drop_here_mobile/common/ui/widgets/narrow_tile.dart';
import 'package:drop_here_mobile/products/ui/pages/product_details_page.dart';
import 'package:drop_here_mobile/routes/bloc/drop_details_bloc/drop_details_bloc.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:get/get.dart';

class DropDetailsPage extends BlocWidget<DropDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final String dropUid;

  DropDetailsPage({this.dropUid});

  @override
  DropDetailsBloc bloc() => DropDetailsBloc()..add(FetchDropDetails(dropUid: dropUid));
  @override
  Widget build(BuildContext context, DropDetailsBloc bloc, _) {
    return Scaffold(
      body: BlocBuilder<DropDetailsBloc, DropDetailsState>(
        buildWhen: (previous, current) => previous.type != current.type,
        builder: (context, state) => Conditional.single(
            context: context,
            conditionBuilder: (_) => state.type == DropDetailsStateType.fetched,
            widgetBuilder: (_) => _buildContent(context, bloc),
            fallbackBuilder: (_) => Center(child: CircularProgressIndicator())),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DropDetailsBloc bloc) {
    final DropDetailedCustomerResponse drop = bloc.state.drop;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DhBackButton(
              padding: EdgeInsets.zero,
            ),
            Text(
              drop.name,
              style: themeConfig.textStyles.primaryTitle,
            ),
            LabeledCircledInfoWithDivider(
              label: "Status",
              text: describeEnum(drop.status),
            ),
            LabeledCircledInfoWithDivider(
              label: "Start time",
              text: drop.startTime.toStringWithoutYear(),
            ),
            LabeledCircledInfoWithDivider(
              label: "End time",
              text: drop.endTime.toStringWithoutYear(),
            ),
            LabeledCircledInfo(
              label: "Seller",
              text: drop.sellerFullName,
            ),
            annotationText("Description"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                drop.description ?? "No content",
                style: themeConfig.textStyles.data,
              ),
            ),
            annotationText("Products"),
            productsCarousel(drop.products),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: SubmitFormButton(
                  isActive: drop.shipmentsAvailable,
                  text: "Create order",
                  onTap: () => {},
                ),
              ),
            ) //TODO: Navigate to create shipment page
          ],
        ),
      ),
    );
  }

  Text annotationText(String text) => Text(
        text,
        style: themeConfig.textStyles.dataAnnotation,
      );

  Widget productsCarousel(List<RouteProductRouteResponse> products) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 14 / 6.4,
        enableInfiniteScroll: false,
        viewportFraction: 0.38,
        initialPage: 0,
      ),
      items: products?.map((product) => ProductInDropDetails(product: product))?.toList(),
    );
  }
}

class ProductInDropDetails extends NarrowTile {
  final RouteProductRouteResponse product;

  ProductInDropDetails({this.product});

  @override
  String get firstLineText => product.productAmountToString;

  @override
  IconData get iconType => Icons.shopping_basket_outlined;

  @override
  String get secondLineText => product.pricePerUnit;

  @override
  String get tileTitle => product.routeProductResponse.name;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => Get.to(ProductDetailsPage(
          product: product.routeProductResponse,
          editable: false,
          limited: product.limitedAmount,
          price: product.price,
          availableAmount: product.amount)),
      child: super.build(context));
}
