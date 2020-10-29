import 'package:drop_here_mobile/accounts/bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/spots/bloc/customer_map_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMapPage extends BlocWidget<CustomerMapBloc> {
  @override
  CustomerMapBloc bloc() => CustomerMapBloc()
    ..add(FetchSpotsEvent(radius: 10000, xCoordinate: 54.397498, yCoordinate: 18.589627));

  @override
  Widget build(BuildContext context, CustomerMapBloc bloc, _) {
    return Scaffold(
        body: BlocBuilder<CustomerMapBloc, CustomerMapState>(
      buildWhen: (previous, current) => previous.type != current.type,
      builder: (context, state) => ConditionalSwitch.single(
          context: context,
          valueBuilder: (_) => state.type,
          caseBuilders: {
            CustomerMapStateType.loading: (_) => Center(child: CircularProgressIndicator()),
            CustomerMapStateType.success: (_) => _buildPageContent(state.spots)
          },
          fallbackBuilder: (_) => SizedBox.shrink()),
    ));
  }

  Widget _buildPageContent(List<SpotBaseCustomerResponse> spots) {
    final ThemeConfig themeConfig = Get.find<ThemeConfig>();
    final Set<Marker> spotsSet = _convertSpotsToMarkers(spots);
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 50.0),
          markers: spotsSet,
          initialCameraPosition: CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.7,
          builder: (BuildContext context, myScrollController) {
            return Container(
              decoration: BoxDecoration(
                  color: themeConfig.colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30))),
              child: Column(
                children: [
                  DhSearchBar(DhListBloc()),
                  //Expanded(child: spotsList(bloc, state, myScrollController)),
                  SizedBox(height: 50.0)
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Set<Marker> _convertSpotsToMarkers(List<SpotBaseCustomerResponse> spots) => spots
      .map((spot) => Marker(
          onTap: () => {},
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          position: LatLng(spot.xcoordinate, spot.ycoordinate),
          markerId: MarkerId(spot.uid)))
      .toSet();

  /*Widget spotsList(List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: spots.length,
        itemBuilder: (BuildContext context, int index) => SpotCard(
              spot: spots[index],
              onTap: () => {},
              onSelectedItem: (value) => BlocProvider.of<CustomerMapBloc>(context).add(event),
            ));
  }*/
}
