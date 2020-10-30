import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/drops/ui/widgets/drops_carousel.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/ui/widgets/products_carousel.dart';
import 'package:drop_here_mobile/routes/bloc/route_details_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class RouteDetailsPage extends BlocWidget<RouteDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int routeId;

  RouteDetailsPage({this.routeId});

  @override
  bloc() => RouteDetailsBloc()..add(FetchRouteDetails(routeId));
  @override
  Widget build(BuildContext context, bloc, _) {
    LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        backgroundColor: themeConfig.colors.white,
        body: SlidingUpPanel(
          maxHeight: 550,
          defaultPanelState: PanelState.OPEN,
          body: Center(child: Text('background')),
          panel: BlocBuilder<RouteDetailsBloc, RouteDetailsState>(
            builder: (context, state) {
              if (state is RouteDetailsInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RouteDetailsFetched) {
                return buildColumnWithData(state, locale);
              }
              return Container();
            },
          ),
        ));
  }

  SafeArea buildColumnWithData(RouteDetailsFetched state, LocaleBundle locale) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.route.name,
                  style: themeConfig.textStyles.primaryTitle,
                ),
                textAndFlatButton(locale.date, state.route.routeDate.toString().substring(0, 10)),
                textAndFlatButton(locale.numberOfProducts, state.route.productsAmount.toString()),
                textAndFlatButton(locale.numberOfDrops, state.route.dropsAmount.toString()),
                textAndFlatButton(locale.status, describeEnum(state.route.status)),
                annotationText(locale.description),
                Text(
                  state.route.description ?? '',
                  style: themeConfig.textStyles.data,
                ),
                Divider(),
                annotationText(locale.assignedSeller),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SellerCard(
                    title: 'Piotruś <3',
                  ),
                ),
                SizedBox(height: 8.0),
                annotationText(locale.drops),
                dropsCarousel(state.route.drops),
                SizedBox(height: 8.0),
                annotationText(locale.products),
                productsCarousel(locale, state.route.products),
                SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
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
