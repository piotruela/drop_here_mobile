import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:drop_here_mobile/spots/ui/pages/spots_map_page.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

part 'edit_spot_event.dart';
part 'edit_spot_state.dart';

class EditSpotBloc extends Bloc<EditSpotEvent, EditSpotFormState> {
  SpotManagementService spotManagementService = Get.find<SpotManagementService>();
  final int id;
  EditSpotBloc({SpotCompanyResponse spot, this.id})
      : super(EditSpotFormState(spotManagementRequest: spot.toRequest));

  @override
  Stream<EditSpotFormState> mapEventToState(
    EditSpotEvent event,
  ) async* {
    if (event is FormChanged) {
      SpotManagementRequest form = event.spot;
      yield state.copyWith(spotManagementRequest: form);
    } else if (event is LocationChanged) {
      yield state.copyWith(
          spotManagementRequest: event.spot.copyWith(
              xcoordinate: event.locationResult.latLng.latitude,
              ycoordinate: event.locationResult.latLng.longitude));
    } else if (event is FormSubmitted) {
      await spotManagementService.updateSpot(event.spot, id);
      Get.to(SpotsMapPage());
    }
  }
}
