part of 'choose_seller_bloc.dart';

abstract class ChooseSellerState extends Equatable {
  const ChooseSellerState();
}

class ChooseSellerInitial extends ChooseSellerState {
  @override
  List<Object> get props => [];
}

class SellersFetched extends ChooseSellerState {
  final int radioValue;
  final List<ProfileInfoResponse> sellers;

  const SellersFetched({this.radioValue, this.sellers});

  SellersFetched copyWith({groupValue, sellers}) {
    return SellersFetched(
        sellers: sellers ?? this.sellers, radioValue: radioValue ?? this.radioValue);
  }

  @override
  List<Object> get props => [radioValue, sellers];
}

class SellersFetchingError extends ChooseSellerState {
  final String error;
  const SellersFetchingError(this.error);
  @override
  List<Object> get props => [error];
}
