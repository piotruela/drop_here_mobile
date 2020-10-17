import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/create_new_item_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/spots/bloc/spots_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SpotsMapPage extends BlocWidget<SpotsListBloc> {
  @override
  SpotsListBloc bloc() => SpotsListBloc()..add(FetchSpots());
  @override
  Widget build(BuildContext context, SpotsListBloc bloc, _) {
    PanelController pc1 = PanelController();
    PanelController pc2 = PanelController();
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<SpotsListBloc, SpotsListState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              Set<Marker> spotMarkers = {};
              if (state is SpotsFetched) {
                spotMarkers = state.spots
                    .map((spot) => Marker(
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                        position: LatLng(spot.xcoordinate, spot.ycoordinate),
                        markerId: MarkerId(spot.id.toString())))
                    .toSet();
                return GoogleMap(
                  markers: spotMarkers,
                  initialCameraPosition:
                      CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
                );
              }
              return Text("Not yet");
            },
          ),
          SlidingUpPanel(
            controller: pc2,
            panel: Column(
              children: [
                panelHeader(context, pc2),
                DhSearchBar(DhListBloc()),
                BlocBuilder<SpotsListBloc, SpotsListState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is SpotsFetched) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.spots.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Text(state.spots[index].name));
                    } else {
                      return SizedBox.shrink();
                    }
                  } /*ConditionalSwitch.single<Type>(
                      context: context,
                      valueBuilder: (_) => state.runtimeType,
                      caseBuilders: {
                        SpotsFetched: (_) => state.,
                        SpotsListInitial: (_) => Text("B")
                      },
                      fallbackBuilder:(_) => SizedBox.shrink())*/ /*Conditional.single(
                      context: context,
                      conditionBuilder: (_) => state is SpotsFetched,
                      widgetBuilder: (_) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {}),
                      fallbackBuilder: (_) => SizedBox.shrink(),
                      )*/
                  ,
                )
              ],
            ),
            minHeight: 120,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          SlidingUpPanel(
            controller: pc1,
            panel: CreateNewItemPage(),
            minHeight: 10,
            maxHeight: 630,
            header: panelHeader(context, pc1),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
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
