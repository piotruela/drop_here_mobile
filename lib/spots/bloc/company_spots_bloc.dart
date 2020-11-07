import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'company_spots_event.dart';
part 'company_spots_state.dart';

class CompanySpotsBloc extends Bloc<CompanySpotsEvent, CompanySpotsState> {
  final SpotManagementService spotManagementService = Get.find<SpotManagementService>();

  CompanySpotsBloc() : super(CompanySpotsState(spots: null, type: CompanySpotsStateType.loading));

  @override
  Stream<CompanySpotsState> mapEventToState(
    CompanySpotsEvent event,
  ) async* {
    if (event is FetchSpotsEvent) {
      yield CompanySpotsState(spots: null, type: CompanySpotsStateType.loading);
      final List<SpotCompanyResponse> spots = await spotManagementService.fetchCompanySpots();
      yield CompanySpotsState(spots: spots, type: CompanySpotsStateType.success);
    } else if (event is FetchSpotDetailsEvent) {
      final SpotMembershipPage members = await spotManagementService.fetchSpotMembers(event.spotId);
      yield CompanySpotsState(
          spots: state.spots,
          type: CompanySpotsStateType.spot_details,
          spot: state.spots.firstWhere(
            (element) => element.id.toString() == event.spotId,
          ),
          members: members);
    } else if (event is CloseSpotDetailsPanel) {
      yield CompanySpotsState(
          spots: state.spots, type: CompanySpotsStateType.success, spot: null, members: null);
    } else if (event is UpdateMembershipStatus) {
      yield CompanySpotsState(
          spots: state.spots, type: CompanySpotsStateType.loading, spot: state.spot, members: null);
      await spotManagementService.updateMembership(
          SpotCompanyMembershipManagementRequest(membershipStatus: event.status),
          event.spotId.toString(),
          event.spotMembershipId.toString());
      final SpotMembershipPage members =
          await spotManagementService.fetchSpotMembers(event.spotId.toString());
      yield CompanySpotsState(
          spots: state.spots,
          type: CompanySpotsStateType.spot_details,
          spot: state.spot,
          members: members);
    }
  }
}
