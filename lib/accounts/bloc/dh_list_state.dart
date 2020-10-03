part of 'dh_list_bloc.dart';

@immutable
abstract class DhListState extends Equatable {
  const DhListState();
}

class DhListInitial extends DhListState {
  const DhListInitial();

  @override
  List<Object> get props => [];
}

class ListLoading extends DhListState {
  const ListLoading();

  @override
  List<Object> get props => [];
}

class ClientsFetched extends DhListState {
  final List<Client> clients;
  const ClientsFetched(this.clients);

  @override
  // TODO: implement props
  List<Object> get props => [clients];
}

class FetchingError extends DhListState {
  final String error;
  const FetchingError(this.error);
  @override
  List<Object> get props => [error];
}
