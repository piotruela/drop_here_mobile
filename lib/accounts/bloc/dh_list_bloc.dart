import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drop_here_mobile/accounts/model/client.dart';
import 'package:drop_here_mobile/accounts/services/clients_list_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dh_list_event.dart';
part 'dh_list_state.dart';

class DhListBloc extends Bloc<DhListEvent, DhListState> {
  final ClientsListService clientsListService;
  DhListBloc(this.clientsListService) : super(DhListInitial());

  @override
  Stream<DhListState> mapEventToState(
    DhListEvent event,
  ) async* {
    yield ListLoading();
    if (event is FetchClients) {
      print('fetchclients');
      try {
        final List<Client> clients = await clientsListService.fetchClientsList();
        print("in");
        yield ClientsFetched(clients);
        print("fetched");
      } catch (e) {
        yield FetchingError(e);
      }
    }
  }
}
