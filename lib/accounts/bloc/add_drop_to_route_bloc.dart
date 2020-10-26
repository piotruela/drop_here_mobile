import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/routes/model/route_request_api.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:equatable/equatable.dart';

part 'add_drop_to_route_event.dart';
part 'add_drop_to_route_state.dart';

class AddDropToRouteBloc extends Bloc<AddDropToRouteEvent, AddDropToRouteFormState> {
  AddDropToRouteBloc() : super(AddDropToRouteFormState(drop: RouteDropRequest()));

  @override
  Stream<AddDropToRouteFormState> mapEventToState(
    AddDropToRouteEvent event,
  ) async* {
    if (event is FormChanged) {
      RouteDropRequest form = event.drop;
      SpotCompanyResponse spot = event.spot;
      yield state.copyWith(drop: form, spot: spot);
    } else if (event is FormSubmitted) {
      //TODO implement
    }
  }
}