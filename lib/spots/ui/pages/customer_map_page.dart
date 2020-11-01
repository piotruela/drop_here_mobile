import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/spots/bloc/customer_spots_bloc.dart';
import 'package:drop_here_mobile/spots/bloc/spot_details2_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerMapPage extends BlocWidget<CustomerSpotsBloc> {
  final PanelController panelController = PanelController();
  @override
  CustomerSpotsBloc bloc() => CustomerSpotsBloc()
    ..add(FetchSpotsEvent(radius: 10000, xCoordinate: 54.397498, yCoordinate: 18.589627));

  @override
  Widget build(BuildContext context, CustomerSpotsBloc bloc, _) {
    return BlocProvider(
      create: (context) => SpotDetails2Bloc(),
      child: Scaffold(
          body: BlocBuilder<CustomerSpotsBloc, CustomerSpotsState>(
        buildWhen: (previous, current) => previous.type != current.type,
        builder: (context, state) => ConditionalSwitch.single(
            context: context,
            valueBuilder: (_) => state.type,
            caseBuilders: {
              CustomerSpotsStateType.failure: (_) {
                bloc.add(
                    FetchSpotsEvent(radius: 10000, xCoordinate: 54.397498, yCoordinate: 18.589627));

                return Center(child: CircularProgressIndicator());
              },
              CustomerSpotsStateType.join_request_sent: (_) {
                bloc.add(
                    FetchSpotsEvent(radius: 10000, xCoordinate: 54.397498, yCoordinate: 18.589627));
                BlocProvider.of<SpotDetails2Bloc>(context).add(CloseSpotDetailsPanel());
                return Center(child: CircularProgressIndicator());
              },
              CustomerSpotsStateType.loading: (_) => Center(child: CircularProgressIndicator()),
              CustomerSpotsStateType.success: (_) =>
                  _buildPageContent(context, bloc, state.spots, panelController)
            },
            fallbackBuilder: (_) => SizedBox.shrink()),
      )),
    );
  }

  Widget _buildPageContent(BuildContext context, CustomerSpotsBloc bloc,
      List<SpotBaseCustomerResponse> spots, PanelController controller) {
    final SpotDetails2Bloc spotDetails2Bloc = BlocProvider.of<SpotDetails2Bloc>(context);
    final Set<Marker> spotsSet = _convertSpotsToMarkers(context, spotDetails2Bloc, spots);
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 50.0),
          markers: spotsSet,
          initialCameraPosition: CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.43,
            builder: (BuildContext context, myScrollController) =>
                _spotsPanel(context, spotDetails2Bloc, spots, myScrollController)),
        BlocBuilder<SpotDetails2Bloc, SpotDetailsState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.type == SpotDetailsStateType.success,
                widgetBuilder: (_) =>
                    _buildSpotDetailsPanel(state.spot.spot, state.spot.drops, controller, bloc),
                fallbackBuilder: (_) => SizedBox.shrink()))
      ],
    );
  }

  Widget _buildSpotDetailsPanel(SpotBaseCustomerResponse spot, List<DropCustomerSpotResponse> drops,
      PanelController controller, CustomerSpotsBloc bloc) {
    return SlidingUpPanel(
        minHeight: 300,
        maxHeight: 630,
        controller: controller,
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        panelBuilder: (myScrollController) => ListView(
              controller: myScrollController,
              shrinkWrap: true,
              children: [
                CustomerSpotDetailsPage(spot: spot, controller: controller, customerSpotsBloc: bloc)
              ],
            ));
  }

  Set<Marker> _convertSpotsToMarkers(BuildContext context, SpotDetails2Bloc spotDetails2Bloc,
          List<SpotBaseCustomerResponse> spots) =>
      spots
          .map((spot) => Marker(
              onTap: () => spotDetails2Bloc.add(FetchSpotDetailsEvent(spotUid: spot.uid)),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              position: LatLng(spot.xcoordinate, spot.ycoordinate),
              markerId: MarkerId(spot.uid)))
          .toSet();

  Widget _spotsPanel(BuildContext context, SpotDetails2Bloc bloc,
      List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return Container(
      child: _spotsList(context, bloc, spots, controller),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  Widget _spotsList(BuildContext context, SpotDetails2Bloc bloc,
      List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return ListView(
        controller: controller,
        shrinkWrap: true,
        children: [DhSearchBar(DhListBloc()), spotsCards(spots, bloc)]);
  }

  Widget spotsCards(List<SpotBaseCustomerResponse> spots, SpotDetails2Bloc bloc) {
    return Column(
        children: spots
            .map((spot) => CustomerSpotCard(
                spot: spot, onTap: () => bloc.add(FetchSpotDetailsEvent(spotUid: spot.uid))))
            .toList());
  }

  Widget panelHeader(BuildContext context) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: SizedBox(
              height: 30,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  child: RaisedButton(onPressed: () => {}),
                  decoration: BoxDecoration(
                      color: themeConfig.colors.textFieldHint,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ))),
        //DHBottomBar(controller: panelController)
      ],
    );
  }
}