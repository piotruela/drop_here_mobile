import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'customer_map_event.dart';
part 'customer_map_state.dart';

class CustomerMapBloc extends Bloc<CustomerMapEvent, CustomerMapState> {
  final SpotsUserService spotsUserService = Get.find<SpotsUserService>();

  CustomerMapBloc() : super(CustomerMapState(spots: null, type: CustomerMapStateType.loading));

  @override
  Stream<CustomerMapState> mapEventToState(
    CustomerMapEvent event,
  ) async* {
    if (event is FetchSpotsEvent) {
      yield CustomerMapState(spots: null, type: CustomerMapStateType.loading);
      final List<SpotBaseCustomerResponse> spots = await spotsUserService.getSpots(
          SpotCustomerRequest(
              radius: event.radius,
              xCoordinate: event.xCoordinate,
              yCoordinate: event.yCoordinate));
      yield CustomerMapState(spots: spots, type: CustomerMapStateType.success);
    }
    if(event is FetchSpotDetailsEvent){
      yield CustomerMapState(spots: state.spots, type: CustomerMapStateType.loading);
      final SpotDetailedCustomerResponse spot = await spotsUserService.getSpotDetails(event.spotUid);
      yield CustomerMapState(spots: state.spots, type: CustomerMapStateType.success, spot: spot);
    }
  }
}
