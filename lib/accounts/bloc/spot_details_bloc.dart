import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'spot_details_event.dart';
part 'spot_details_state.dart';

class SpotDetailsBloc extends Bloc<SpotDetailsEvent, SpotDetailsState> {
  SpotDetailsBloc() : super(SpotDetailsInitial());

  @override
  Stream<SpotDetailsState> mapEventToState(
    SpotDetailsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
