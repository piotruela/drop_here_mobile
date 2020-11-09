import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:equatable/equatable.dart';

part 'client_details_management_event.dart';
part 'client_details_management_state.dart';

class ClientDetailsManagementBloc
    extends Bloc<ClientDetailsManagementEvent, ClientDetailsManagementState> {
  ClientDetailsManagementBloc() : super(ClientDetailsManagementState());

  @override
  Stream<ClientDetailsManagementState> mapEventToState(
    ClientDetailsManagementEvent event,
  ) async* {
    if (event is ClientDetailsInitial) {
      //yield ClientDetailsManagementState(event.customerResponse);
    }
  }
}
