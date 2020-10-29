import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:drop_here_mobile/spots/bloc/customer_spots_bloc.dart';
import 'package:drop_here_mobile/spots/bloc/spot_details2_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomerMapPage extends BlocWidget<CustomerSpotsBloc> {
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
              CustomerSpotsStateType.loading: (_) => Center(child: CircularProgressIndicator()),
              CustomerSpotsStateType.success: (_) => _buildPageContent(context, bloc, state.spots)
            },
            fallbackBuilder: (_) => SizedBox.shrink()),
      )),
    );
  }

  Widget _buildPageContent(
      BuildContext context, CustomerSpotsBloc bloc, List<SpotBaseCustomerResponse> spots) {
    final SpotDetails2Bloc spotDetails2Bloc = BlocProvider.of<SpotDetails2Bloc>(context);
    final Set<Marker> spotsSet = _convertSpotsToMarkers(context, spotDetails2Bloc, spots);
    return Stack(
      children: [
        GoogleMap(
          padding: EdgeInsets.only(bottom: 50.0),
          markers: spotsSet,
          initialCameraPosition: CameraPosition(zoom: 15, target: LatLng(54.397498, 18.589627)),
        ),
        BlocBuilder<SpotDetails2Bloc, SpotDetailsState>(
            buildWhen: (previous, current) => previous.type != current.type,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.type == SpotDetailsStateType.success,
                widgetBuilder: (_) => _buildSpotDetailsPanel(state.spot.spot, state.spot.drops),
                fallbackBuilder: (_) => SizedBox.shrink()))
      ],
    );
  }

  Widget _buildSpotDetailsPanel(
      SpotBaseCustomerResponse spot, List<DropCustomerSpotResponse> drops) {
    return SlidingUpPanel(
        panel: SpotDetailsPage(
            spot: SpotCompanyResponse(
                name: spot.name,
                description: spot.description,
                requiresAccept: spot.requiresAccept,
                requiresPassword: spot.requiresPassword,
                hidden: false)));
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

  /*Widget spotsList(List<SpotBaseCustomerResponse> spots, ScrollController controller) {
    return ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: spots.length,
        itemBuilder: (BuildContext context, int index) => SpotCard(
              spot: spots[index],
              onTap: () => {},
              onSelectedItem: (value) => BlocProvider.of<CustomerSpotsBloc>(context).add(event),
            ));
  }*/
}
