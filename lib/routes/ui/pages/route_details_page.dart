import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_here_mobile/accounts/ui/pages/manage_route_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/edit_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/rounded_flat_button.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/seller_card.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/choosable_button.dart';
import 'package:drop_here_mobile/common/ui/widgets/dh_back_button.dart';
import 'package:drop_here_mobile/locale/locale_bundle.dart';
import 'package:drop_here_mobile/locale/localization.dart';
import 'package:drop_here_mobile/products/ui/widgets/products_carousel.dart';
import 'package:drop_here_mobile/routes/bloc/route_details_bloc.dart';
import 'package:drop_here_mobile/routes/model/route_response_api.dart';
import 'package:drop_here_mobile/routes/ui/widgets/drop_card.dart';
import 'package:drop_here_mobile/shipments/ui/pages/dashboard_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';

class RouteDetailsPage extends BlocWidget<RouteDetailsBloc> {
  final ThemeConfig themeConfig = Get.find<ThemeConfig>();
  final int routeId;

  RouteDetailsPage({this.routeId});

  @override
  bloc() => RouteDetailsBloc()..add(FetchRouteDetails(routeId: routeId));
  @override
  Widget build(BuildContext context, bloc, _) {
    final LocaleBundle locale = Localization.of(context).bundle;
    return Scaffold(
        backgroundColor: themeConfig.colors.white,
        body: BlocBuilder<RouteDetailsBloc, RouteDetailsState>(
          buildWhen: (previous, current) => previous.route != current.route,
          builder: (context, state) {
            if (state.type == RouteDetailsStateType.loading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return buildColumnWithData(context, bloc, state, locale);
            }
          },
        ));
  }

  SafeArea buildColumnWithData(
      BuildContext context, RouteDetailsBloc bloc, RouteDetailsState state, LocaleBundle localeBundle) {
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
                  backAction: () => Get.to(DashboardPage()),
                ),
                pageTitle(bloc, state.route.name),
                textAndFlatButton(localeBundle.date, state.route.routeDate),
                textAndFlatButton("Auto-accept orders",
                    state.route.acceptShipmentsAutomatically ? localeBundle.yes : localeBundle.no),
                textAndFlatButton(localeBundle.numberOfProducts, state.route.productsAmount.toString()),
                textAndFlatButton(localeBundle.numberOfDrops, state.route.dropsAmount.toString()),
                textAndFlatButton(localeBundle.status, describeEnum(state.route.status)),
                _updateStatusButton(context, bloc),
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
                bloc.state.route.drops.isNotEmpty ? dropsCarousel(state.route.drops) : noContentText,
                SizedBox(height: 8.0),
                annotationText(localeBundle.products),
                bloc.state.route.products.isNotEmpty
                    ? productsCarousel(localeBundle, state.route.products)
                    : noContentText,
                SizedBox(height: 30.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pageTitle(RouteDetailsBloc bloc, String text) {
    return Wrap(
      children: [
        Text(
          text,
          style: themeConfig.textStyles.primaryTitle,
        ),
        SizedBox(
          width: 10.0,
        ),
        bloc.state.route.status == RouteStatus.UNPREPARED
            ? editButton(onPressed: () {
                Get.to(EditRoutePage(
                  route: bloc.state.route,
                ));
              })
            : SizedBox.shrink(),
      ],
    );
  }

  CarouselSlider dropsCarousel(List<DropRouteResponse> drops) {
    return CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 12 / 7.4,
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

  Widget get noContentText => Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0), child: Text("No content", style: themeConfig.textStyles.data));

  Text annotationText(String text) {
    return Text(
      text,
      style: themeConfig.textStyles.dataAnnotation,
    );
  }

  Widget _updateStatusButton(BuildContext context, RouteDetailsBloc bloc) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConditionalSwitch.single(
          context: context,
          valueBuilder: (_) => bloc.state.route.status,
          caseBuilders: {
            RouteStatus.UNPREPARED: (_) => _changeToPreparedButton(context),
            RouteStatus.ONGOING: (_) => _changeToCancelledButton(context),
            RouteStatus.FINISHED: (_) => SizedBox.shrink()
          },
          fallbackBuilder: (_) => _changeStatusButton(context, bloc.state.route.status)),
    );
  }

  Widget _changeToPreparedButton(BuildContext context) => ChoosableButtonWithSubText(
      text: "Change status to prepared",
      subText: "Allows to order products from\n this route",
      chooseAction: () => BlocProvider.of<RouteDetailsBloc>(context)
          .add(UpdateRouteStatus(routeId: routeId, status: RouteStatus.PREPARED)));

  Widget _changeToCancelledButton(BuildContext context, {bool shouldPop = false}) => ChoosableButtonWithSubText(
      text: "Change status to cancelled",
      subText: "Cancel route and all\n uncompleted drops",
      chooseAction: () {
        BlocProvider.of<RouteDetailsBloc>(context)
            .add(UpdateRouteStatus(routeId: routeId, status: RouteStatus.CANCELLED));
        if (shouldPop) Navigator.pop(context);
      });

  Widget _changeToOngoingButton(BuildContext context, {bool shouldPop = false}) => ChoosableButtonWithSubText(
      text: "Change status to ongoing",
      subText: "Changes status to ongoing",
      chooseAction: () {
        BlocProvider.of<RouteDetailsBloc>(context)
            .add(UpdateRouteStatus(routeId: routeId, status: RouteStatus.ONGOING));
        if (shouldPop) Navigator.pop(context);
      });

  Widget _changeStatusButton(BuildContext context, RouteStatus currentStatus) => ChoosableButtonWithSubText(
      text: "Change status",
      subText: "Opens dialog where you\ncan change status",
      chooseAction: () async => await showDialog(context: context, child: _changeStatusDialog(context, currentStatus)));

  Widget _changeStatusDialog(BuildContext context, RouteStatus currentStatus) {
    return AlertDialog(
        title: Align(child: Text("Change status", style: themeConfig.textStyles.secondaryTitle)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textAndFlatButton("Current status", describeEnum(currentStatus)),
            _changeToOngoingButton(context, shouldPop: true),
            _changeToCancelledButton(context, shouldPop: true)
          ],
        ));
  }
}
