import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/ui/pages/spot_details_page.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'spots_list_event.dart';
part 'spots_list_state.dart';

class SpotsMapBloc extends Bloc<SpotsMapEvent, SpotsMapState> {
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  SpotsMapBloc() : super(SpotsMapState());

  @override
  Stream<SpotsMapState> mapEventToState(
    SpotsMapEvent event,
  ) async* {
    if (event is FetchSpots) {
      List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield SpotsFetched(spots: spots);
    } else if (event is DeleteSpot) {
      await spotManagementService.deleteSpot(event.spotId);
      List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield SpotsFetched(spots: spots);
    } else if (event is SpotPinClicked) {
      final SlidingUpPanel spotPanel = SlidingUpPanel(
          header: mapPanelHeader(event.context, this),
          minHeight: 200.0,
          maxHeight: 600.0,
          defaultPanelState: PanelState.CLOSED,
          panel: SpotDetailsPage(spot: event.spot));
      yield SpotDetailsPanelCreated(spotDetailsPanel: spotPanel);
    } else if (event is SpotPanelClosed) {
      yield SpotDetailsPanelClosed(spotDetailsPanel: null);
    }
  }
}

Widget mapPanelHeader(BuildContext context, SpotsMapBloc bloc) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
            icon: Icon(
              Icons.close,
              size: 40.0,
            ),
            onPressed: () => bloc.add(SpotPanelClosed()))
      ],
    ),
  );
}
