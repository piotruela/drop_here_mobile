part of 'choose_seller_bloc.dart';

abstract class ChooseSellerEvent extends Equatable {
  const ChooseSellerEvent();
}

class FetchSellers extends ChooseSellerEvent {
  const FetchSellers();

  @override
  List<Object> get props => [];
}

class ChangeGroupValue extends ChooseSellerEvent {
  final int groupValue;
  final List<ProfileInfoResponse> sellers;
  ChangeGroupValue(this.groupValue, this.sellers);

  @override
  List<Object> get props => [groupValue, sellers];
}

class FilterSpotsForDrop extends ChooseSellerEvent {
  final String filter;
  FilterSpotsForDrop({this.filter});

  @override
  List<Object> get props => [filter];
}

class SearchSpotsForDrop extends ChooseSellerEvent {
  final String searchText;
  SearchSpotsForDrop({this.searchText});

  @override
  List<Object> get props => [searchText];
}
