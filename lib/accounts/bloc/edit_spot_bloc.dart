import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';

part 'edit_spot_event.dart';
part 'edit_spot_state.dart';

class EditSpotBloc extends Bloc<EditSpotEvent, EditSpotFormState> {
  EditSpotBloc()
      : super(EditSpotFormState(locationMap: null, spotManagementRequest: SpotManagementRequest()));

  @override
  Stream<EditSpotFormState> mapEventToState(
    EditSpotEvent event,
  ) async* {
    if (event is FormChanged) {
      SpotManagementRequest form = event.spot;
      yield state.copyWith(spotManagementRequest: form, locationMap: event?.locationMap);
    } else if (event is FormSubmitted) {
      //TODO
    }
  }
}
