import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/ui/widgets/products_carousel.dart';
import 'package:drop_here_mobile/routes/bloc/route_details_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/ui/widgets/drop_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RouteDetailsPage extends BlocWidget<RouteDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int routeId;

  RouteDetailsPage({this.routeId});

  @override
  bloc() => RouteDetailsBloc()..add(FetchRouteDetails(routeId));
  @override
  Widget build(BuildContext context, bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        backgroundColor: themeConfig.colors.white,
        body: BlocBuilder<RouteDetailsBloc, RouteDetailsState>(
          builder: (context, state) {
            if (state is RouteDetailsInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is RouteDetailsFetched) {
              return buildColumnWithData(state, locale);
            }
            return Container();
          },
        ));
  }

  SafeArea buildColumnWithData(RouteDetailsFetched state, LocaleBundle localeBundle) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DhBackButton(
                  padding: EdgeInsets.zero,
                ),
                Text(
                  state.route.name,
                  style: themeConfig.textStyles.primaryTitle,
                ),
                textAndFlatButton(localeBundle.date, state.route.routeDate),
                textAndFlatButton("Auto-accept orders",
                    state.route.acceptShipmentsAutomatically ? localeBundle.yes : localeBundle.no),
                textAndFlatButton(localeBundle.numberOfProducts, state.route.productsAmount.toString()),
                textAndFlatButton(localeBundle.numberOfDrops, state.route.dropsAmount.toString()),
                textAndFlatButton(localeBundle.status, describeEnum(state.route.status)),
                annotationText(localeBundle.description),
                Text(
                  state.route.description ?? localeBundle.noContent,
                  style: themeConfig.textStyles.data,
                ),
                Divider(),
                annotationText(localeBundle.assignedSeller),
                state.route?.profileUid != null
                    ? SellerCard(
                        title: state.route.sellerFullName,
                      )
                    : Text(
                        "No seller assigned",
                        style: themeConfig.textStyles.data,
                      ),
                SizedBox(height: 8.0),
                annotationText(localeBundle.drops),
                dropsCarousel(state.route.drops),
                SizedBox(height: 8.0),
                annotationText(localeBundle.products),
                productsCarousel(localeBundle, state.route.products),
                SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider dropsCarousel(List<DropRouteResponse> drops) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 14 / 7.4,
          enableInfiniteScroll: false,
          viewportFraction: 0.5,
          initialPage: 0,
        ),
        items: drops?.map((element) => CompanyRouteDetailsDropCard(drop: element))?.toList());
  }

  Column textAndFlatButton(String text, String buttonText) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            annotationText(text),
            RoundedFlatButton(
              text: buttonText,
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Text annotationText(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.dataAnnotation,
    );
  }
}
