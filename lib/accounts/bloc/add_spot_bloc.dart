import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

part 'add_spot_event.dart';
part 'add_spot_state.dart';

class AddSpotBloc extends Bloc<AddSpotEvent, AddSpotFormState> {
  AddSpotBloc()
      : super(AddSpotFormState(
            spotManagementRequest: SpotManagementRequest(
                requiredPassword: false,
                hidden: false,
                requiredAccept: false,
                estimatedRadiusMaters: 20)));

  @override
  Stream<AddSpotFormState> mapEventToState(
    AddSpotEvent event,
  ) async* {
    if (event is FormChanged) {
      SpotManagementRequest form = event.spotManagementRequest;
      yield state.copyWith(spotManagementRequest: form);
    } else if (event is LocationChanged) {
      yield state.copyWith(
          spotManagementRequest: event.spotManagementRequest.copyWith(
              xcoordinate: event.locationResult.latLng.latitude,
              ycoordinate: event.locationResult.latLng.longitude));
    } else if (event is FormSubmitted) {
      print("No klikłem");
    }
  }
}
