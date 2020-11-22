import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/spots/bloc/customer_spots_bloc/customer_spots_bloc.dart';
import 'package:drop_here_mobile/spots/bloc/spot_details_bloc/spot_details_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/ui/pages/spot_details_page.dart';
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

  CustomerMapPage(
      {this.initialXCoordinate = 54.397498, this.initialYCoordinate = 18.589627, this.spotDetailsOnLoadEvent});

  final double initialXCoordinate;
  final double initialYCoordinate;
  final int _radius = 10000;
  final SpotDetailsEvent spotDetailsOnLoadEvent;

  @override
  CustomerSpotsBloc bloc() {
    return CustomerSpotsBloc()
      ..add(FetchSpotsEvent(radius: _radius, xCoordinate: initialXCoordinate, yCoordinate: initialYCoordinate));
  }

  @override
  Widget build(BuildContext context, CustomerSpotsBloc bloc, _) {
    return BlocProvider(
      create: (context) {
        if (spotDetailsOnLoadEvent != null) {
          return SpotDetailsBloc()..add(spotDetailsOnLoadEvent);
        }
        return SpotDetailsBloc();
      },
      child: Scaffold(
          body: BlocBuilder<CustomerSpotsBloc, CustomerSpotsState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => ConditionalSwitch.single(
                context: context,
                valueBuilder: (_) => state.type,
                caseBuilders: {
                  CustomerSpotsStateType.failure: (_) {
                    bloc.add(FetchSpotsEvent(
                        radius: _radius, xCoordinate: initialXCoordinate, yCoordinate: initialYCoordinate));

                    return Center(child: CircularProgressIndicator());
                  },
                  CustomerSpotsStateType.spot_managed: (_) {
                    bloc.add(FetchSpotsEvent(
                        radius: _radius, xCoordinate: initialXCoordinate, yCoordinate: initialYCoordinate));
                    BlocProvider.of<SpotDetailsBloc>(context).add(CloseSpotDetailsPanel());
                    return Center(child: CircularProgressIndicator());
                  },
                  CustomerSpotsStateType.loading: (_) => Center(child: CircularProgressIndicator()),
                  CustomerSpotsStateType.success: (_) => _buildPageContent(context, bloc, state.spots, panelController)
                },
                fallbackBuilder: (_) => SizedBox.shrink()),
          ),
          bottomNavigationBar: CustomerBottomBar(sectionIndex: 2)),
    );
  }

  Widget _buildPageContent(
      BuildContext context, CustomerSpotsBloc bloc, List<SpotBaseCustomerResponse> spots, PanelController controller) {
    final SpotDetailsBloc spotDetailsBloc = BlocProvider.of<SpotDetailsBloc>(context);
    final Set<Marker> spotsSet = _convertSpotsToMarkers(context, spotDetailsBloc, spots);
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 100.0),
          markers: spotsSet,
          initialCameraPosition: CameraPosition(zoom: 15, target: LatLng(initialXCoordinate, initialYCoordinate)),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.43,
            builder: (BuildContext context, myScrollController) =>
                _spotsPanel(context, spotDetailsBloc, spots, myScrollController)),
        BlocBuilder<SpotDetailsBloc, SpotDetailsState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.type == SpotDetailsStateType.success,
                widgetBuilder: (_) => _buildSpotDetailsPanel(state.spot, controller, bloc),
                fallbackBuilder: (_) => SizedBox.shrink()))
      ],
    );
  }

  Widget _buildSpotDetailsPanel(SpotDetailedCustomerResponse spot, PanelController controller, CustomerSpotsBloc bloc) {
    return SlidingUpPanel(
        minHeight: 300,
        maxHeight: 630,
        controller: controller,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        panelBuilder: (myScrollController) => ListView(
              controller: myScrollController,
              shrinkWrap: true,
              children: [CustomerSpotDetailsPage(spotAndDrops: spot, controller: controller, customerSpotsBloc: bloc)],
            ));
  }

  Set<Marker> _convertSpotsToMarkers(
      BuildContext context, SpotDetailsBloc spotDetailsBloc, List<SpotBaseCustomerResponse> spots) {
    return spots
        .map((spot) => Marker(
            onTap: () => spotDetailsBloc.add(FetchSpotDetailsEvent(spotUid: spot.uid)),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            position: LatLng(spot.xcoordinate, spot.ycoordinate),
            markerId: MarkerId(spot.uid)))
        .toSet();
  }

  Widget _spotsPanel(
      BuildContext context, SpotDetailsBloc bloc, List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return Container(
      child: _spotsList(context, bloc, spots, controller),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  Widget _spotsList(
      BuildContext context, SpotDetailsBloc bloc, List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return ListView(controller: controller, shrinkWrap: true, children: [spotsCards(spots, bloc)]);
  }

  Widget spotsCards(List<SpotBaseCustomerResponse> spots, SpotDetailsBloc bloc) {
    return Column(
        children: spots
            .map(
                (spot) => CustomerSpotCard(spot: spot, onTap: () => bloc.add(FetchSpotDetailsEvent(spotUid: spot.uid))))
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
                  decoration:
                      BoxDecoration(color: themeConfig.colors.textFieldHint, borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ))),
        //CompanyBottomBar(controller: panelController)
      ],
    );
  }
}
