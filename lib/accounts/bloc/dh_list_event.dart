part of 'dh_list_bloc.dart';

@immutable
abstract class DhListEvent extends Equatable {
  const DhListEvent();
}

class FetchClients extends DhListEvent {
  FetchClients();

  @override
  List<Object> get props => [];
}

class FilterClients extends DhListEvent {
  final String filter;
  FilterClients({this.filter});

  @override
  List<Object> get props => [filter];
}

class SearchClients extends DhListEvent {
  final String searchText;
  SearchClients({this.searchText});

  @override
  List<Object> get props => [searchText];
}
