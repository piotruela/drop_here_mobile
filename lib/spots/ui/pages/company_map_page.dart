import 'package:drop_here_mobile/accounts/bloc/list_bloc/dh_list_bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/accounts/ui/widgets/dh_search_bar.dart';
import 'package:drop_here_mobile/common/ui/widgets/add_new_item_panel.dart';
import 'package:drop_here_mobile/common/ui/widgets/bloc_widget.dart';
import 'package:drop_here_mobile/common/ui/widgets/bottom_bar.dart';
import 'package:drop_here_mobile/spots/bloc/company_spots_bloc/company_spots_bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/ui/widgets/spot_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CompanyMapPage extends BlocWidget<CompanySpotsBloc> {
  final PanelController detailsPanelController = PanelController();
  final PanelController addNewItemPanelController = PanelController();

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
                  _buildPageContent(context, bloc, state.spots, detailsPanelController, addNewItemPanelController),
              CompanySpotsStateType.success: (_) =>
                  _buildPageContent(context, bloc, state.spots, detailsPanelController, addNewItemPanelController)
            },
            fallbackBuilder: (_) => SizedBox.shrink()),
      ),
      bottomNavigationBar: DHBottomBar(controller: addNewItemPanelController, selectedIndex: 2),
    );
  }

  Widget _buildPageContent(BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots,
      PanelController detailsPanelController, PanelController addNewItemPanelController) {
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
            maxChildSize: 0.70,
            builder: (BuildContext context, myScrollController) =>
                _spotsPanel(context, bloc, spots, myScrollController)),
        BlocBuilder<CompanySpotsBloc, CompanySpotsState>(
            buildWhen: (previous, current) => previous.spot != current.spot,
            builder: (context, state) => Conditional.single(
                context: context,
                conditionBuilder: (_) => state.spot != null,
                widgetBuilder: (_) => _buildSpotDetailsPanel(state.spot, detailsPanelController, bloc, state.members),
                fallbackBuilder: (_) => SizedBox.shrink())),
        AddNewItemPanel(
          controller: addNewItemPanelController,
        ),
      ],
    );
  }

  Widget _buildSpotDetailsPanel(
      SpotCompanyResponse spot, PanelController controller, CompanySpotsBloc bloc, SpotMembershipPage members) {
    return SlidingUpPanel(
        minHeight: 300,
        maxHeight: 630,
        controller: controller,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        panelBuilder: (myScrollController) => CompanySpotDetailsPage(
              spot: spot,
              controller: controller,
              bloc: bloc,
              members: members,
              scrollController: myScrollController,
            ));
  }

  Set<Marker> _convertSpotsToMarkers(BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots) =>
      spots
          .map((spot) => Marker(
              onTap: () => bloc.add(FetchSpotDetailsEvent(spotId: spot.id.toString())),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
              position: LatLng(spot.xcoordinate, spot.ycoordinate),
              markerId: MarkerId(spot.id.toString())))
          .toSet();

  Widget _spotsPanel(
      BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots, ScrollController controller) {
    return Container(
      child: _spotsList(context, bloc, spots, controller),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    );
  }

  Widget _spotsList(
      BuildContext context, CompanySpotsBloc bloc, List<SpotCompanyResponse> spots, ScrollController controller) {
    return ListView(
        controller: controller, shrinkWrap: true, children: [DhSearchBar(DhListBloc()), spotsCards(spots, bloc)]);
  }

  Widget spotsCards(List<SpotCompanyResponse> spots, CompanySpotsBloc bloc) {
    return Column(
        children: spots
            .map((spot) => CompanySpotListCard(
                spot: spot, onTap: () => bloc.add(FetchSpotDetailsEvent(spotId: spot.id.toString()))))
            .toList());
  }
}
