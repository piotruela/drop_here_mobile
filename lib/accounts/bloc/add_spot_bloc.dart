import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';

part 'add_spot_event.dart';
part 'add_spot_state.dart';

class AddSpotBloc extends Bloc<AddSpotEvent, AddSpotFormState> {
  AddSpotBloc()
      : super(AddSpotFormState(locationMap: null, spotManagementRequest: SpotManagementRequest()));

  @override
  Stream<AddSpotFormState> mapEventToState(
    AddSpotEvent event,
  ) async* {
    if (event is FormChanged) {
      SpotManagementRequest form = event.spotManagementRequest;
      yield state.copyWith(spotManagementRequest: form, locationMap: event.locationMap);
    } else if (event is FormSubmitted) {
      //TODO
    }
  }
}
