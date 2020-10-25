import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/spots/bloc/spots_list_bloc.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
        itemBuilder: (BuildContext context, int index) => SpotCard(
              spot: state.spots[index],
              onTap: () => Get.to(SpotDetailsPage(spot: state.spots[index])),
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
