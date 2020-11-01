import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'customer_spots_event.dart';
part 'customer_spots_state.dart';

class CustomerSpotsBloc extends Bloc<CustomerSpotsEvent, CustomerSpotsState> {
  final SpotsUserService spotsUserService = Get.find<SpotsUserService>();

  CustomerSpotsBloc()
      : super(CustomerSpotsState(spots: null, type: CustomerSpotsStateType.loading));

  @override
  Stream<CustomerSpotsState> mapEventToState(
    CustomerSpotsEvent event,
  ) async* {
    if (event is FetchSpotsEvent) {
      yield CustomerSpotsState(spots: null, type: CustomerSpotsStateType.loading);
      final List<SpotBaseCustomerResponse> spots = await spotsUserService.getSpots(
          SpotCustomerRequest(
              radius: event.radius,
              xCoordinate: event.xCoordinate,
              yCoordinate: event.yCoordinate));
      yield CustomerSpotsState(spots: spots, type: CustomerSpotsStateType.success);
    }
    if (event is SendSpotJoiningRequest) {
      yield CustomerSpotsState(spots: null, type: CustomerSpotsStateType.loading);
      ResourceOperationResponse response =
          await spotsUserService.joinSpot(event.spotUid, event.companyUid, event.request);
      yield CustomerSpotsState(
          spots: null,
          type: response.operationStatus == OperationStatus.ERROR
              ? CustomerSpotsStateType.failure
              : CustomerSpotsStateType.join_request_sent);
    }
  }
}
