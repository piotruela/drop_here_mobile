import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_spot_event.dart';
part 'edit_spot_state.dart';

class EditSpotBloc extends Bloc<EditSpotEvent, EditSpotState> {
  EditSpotBloc() : super(EditSpotInitial());

  @override
  Stream<EditSpotState> mapEventToState(
    EditSpotEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
