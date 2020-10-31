import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/spots/bloc/company_spots_bloc.dart';
import 'package:drop_here_mobile/spots/bloc/spots_list_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CompanyMapPage extends BlocWidget<CompanySpotsBloc> {
  final PanelController pc1 = PanelController();

  @override
  CompanySpotsBloc bloc() => CompanySpotsBloc()..add(FetchSpotsEvent());

  @override
  Widget build(BuildContext context, CompanySpotsBloc bloc, _) {
    return Scaffold(
      body: BlocBuilder<CompanySpotsBloc, CompanySpotsState>(
        buildWhen: (previous, current) =>
            previous.type != current.type || current.type == CompanySpotsStateType.spot_details,
        builder: (context, state) => ConditionalSwitch.single(
            context: context,
            valueBuilder: (_) => state.type,
            caseBuilders: {
              CompanySpotsStateType.loading: (_) => Center(child: CircularProgressIndicator()),
              CompanySpotsStateType.spot_details: (_) =>
                  _buildPageContent(context, bloc, state.spots, pc1),
              CompanySpotsStateType.success: (_) =>
                  _buildPageContent(context, bloc, state.spots, pc1)
            },
            fallbackBuilder: (_) => SizedBox.shrink()),
      ),
    );
  }

  Widget _buildPageContent(BuildContext context, CompanySpotsBloc bloc,
      List<SpotCompanyResponse> spots, PanelController controller) {
    final Set<Marker> spotsSet = _convertSpotsToMarkers(context, bloc, spots);
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 100.0),
          markers: spotsSet,
          initialCameraPosition: CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
        ),
        DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.43,
            builder: (BuildContext context, myScrollController) =>
                _spotsPanel(context, bloc, spots, myScrollController)),
        BlocBuilder<CompanySpotsBloc, CompanySpotsState>(
            buildWhen: (previous, current) => previous.spot != current.spot,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.spot != null,
                widgetBuilder: (_) =>
                    _buildSpotDetailsPanel(state.spot, controller, bloc, state.members),
                fallbackBuilder: (_) => SizedBox.shrink()))
      ],
    );
  }

  Widget _buildSpotDetailsPanel(SpotCompanyResponse spot, PanelController controller,
      CompanySpotsBloc bloc, SpotMembershipPage members) {
    return SlidingUpPanel(
        minHeight: 300,
        maxHeight: 630,
        controller: controller,
        borderRadius:
            const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        panelBuilder: (myScrollController) => Column(
              children: [
                CompanySpotDetailsPage(
                    spot: spot, controller: controller, bloc: bloc, members: members)
              ],
            ));
  }

  Set<Marker> _convertSpotsToMarkers(
          BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots) =>
      spots
          .map((spot) => Marker(
              onTap: () => bloc.add(FetchSpotDetailsEvent(spotId: spot.id.toString())),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              position: LatLng(spot.xcoordinate, spot.ycoordinate),
              markerId: MarkerId(spot.id.toString())))
          .toSet();

  Widget _spotsPanel(BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots,
      ScrollController controller) {
    return Container(
      child: _spotsList(context, bloc, spots, controller),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  Widget _spotsList(BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots,
      ScrollController controller) {
    return ListView(
        controller: controller,
        shrinkWrap: true,
        children: [DhSearchBar(DhListBloc()), spotsCards(spots, bloc)]);
  }

  Widget spotsCards(List<SpotCompanyResponse> spots, CompanySpotsBloc bloc) {
    return Column(
        children: spots
            .map((spot) => CompanySpotCard(
                spot: spot,
                onTap: () => bloc.add(FetchSpotDetailsEvent(spotId: spot.id.toString()))))
            .toList());
  }
}

class SpotsMapPage extends BlocWidget<SpotsMapBloc> {
  final PanelController pc1 = PanelController();
  final PanelController pc2 = PanelController();

  @override
  SpotsMapBloc bloc() => SpotsMapBloc()..add(FetchSpots());
  @override
  Widget build(BuildContext context, SpotsMapBloc bloc, _) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<SpotsMapBloc, SpotsMapState>(
            buildWhen: (previous, current) => previous != current && current is SpotsFetched,
            builder: (context, state) {
              Set<Marker> spotMarkers = {};
              if (state is SpotsFetched) {
                spotMarkers = state.spots
                    .map((spot) => Marker(
                        onTap: () => bloc.add(SpotPinClicked(spot: spot, context: context)),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                        position: LatLng(spot.xcoordinate, spot.ycoordinate),
                        markerId: MarkerId(spot.id.toString())))
                    .toSet();
                return GoogleMap(
                  padding: EdgeInsets.only(bottom: 50.0),
                  markers: spotMarkers,
                  initialCameraPosition:
                      CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
                );
              } else {
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 0.7,
              builder: (BuildContext context, myScrollController) {
                return BlocBuilder<SpotsMapBloc, SpotsMapState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is SpotsFetched) {
                      final ThemeConfig themeConfig = Get.find<ThemeConfig>();
                      return Container(
                        decoration: BoxDecoration(
                            color: themeConfig.colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            DhSearchBar(DhListBloc()),
                            Expanded(child: spotsList(bloc, state, myScrollController)),
                            SizedBox(height: 50.0)
                          ],
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                );
              }),
          SlidingUpPanel(
            controller: pc1,
            panel: CreateNewItemPage(),
            minHeight: 10,
            maxHeight: 630,
            header: panelHeader(context, pc1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          BlocBuilder<SpotsMapBloc, SpotsMapState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is SpotDetailsPanelCreated) {
                return state.spotDetailsPanel;
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: DHBottomBar(
                selectedIndex: 2,
                controller: pc1,
              ))
        ],
      ),
    );
  }

  Widget spotsList(SpotsMapBloc bloc, SpotsFetched state, ScrollController controller) {
    return ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: state.spots.length,
        itemBuilder: (BuildContext context, int index) => CompanySpotCard(
              spot: state.spots[index],
              onTap: () => Get.to(CompanySpotDetailsPage(spot: state.spots[index])),
              onSelectedItem: (value) => bloc.add(DeleteSpot(spotId: int.parse(value))),
            ));
  }

  Widget panelHeader(BuildContext context, PanelController panelController) {
    ThemeConfig themeConfig = Get.find<ThemeConfig>();
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
                  child: RaisedButton(onPressed: () => panelController.close()),
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
