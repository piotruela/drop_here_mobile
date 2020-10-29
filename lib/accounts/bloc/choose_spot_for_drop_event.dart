part of 'choose_spot_for_drop_bloc.dart';

abstract class ChooseSpotForDropEvent extends Equatable {
  const ChooseSpotForDropEvent();
}

class FetchSpotsForDrop extends ChooseSpotForDropEvent {
  FetchSpotsForDrop();

  @override
  List<Object> get props => [];
}

class ChangeGroupValue extends ChooseSpotForDropEvent {
  final int groupValue;
  final List<SpotCompanyResponse> spots;
  ChangeGroupValue(this.groupValue, this.spots);

  @override
  List<Object> get props => [groupValue, spots];
}

class FilterSpotsForDrop extends ChooseSpotForDropEvent {
  final String filter;
  FilterSpotsForDrop({this.filter});

  @override
  List<Object> get props => [filter];
}

class SearchSpotsForDrop extends ChooseSpotForDropEvent {
  final String searchText;
  SearchSpotsForDrop({this.searchText});

  @override
  List<Object> get props => [searchText];
}
