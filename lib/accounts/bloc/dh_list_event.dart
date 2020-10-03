part of 'dh_list_bloc.dart';

@immutable
abstract class DhListEvent extends Equatable {
  const DhListEvent();
}

class FetchClients extends DhListEvent {
  //TODO fetch clients

  FetchClients();

  @override
  List<Object> get props => [];
}
