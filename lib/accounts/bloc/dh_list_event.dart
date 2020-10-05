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

class FetchSellers extends DhListEvent {
  FetchSellers();

  @override
  List<Object> get props => [];
}

class FilterSellers extends DhListEvent {
  final String filter;
  FilterSellers({this.filter});

  @override
  List<Object> get props => [filter];
}

class SearchSellers extends DhListEvent {
  final String searchText;
  SearchSellers({this.searchText});

  @override
  List<Object> get props => [searchText];
}
