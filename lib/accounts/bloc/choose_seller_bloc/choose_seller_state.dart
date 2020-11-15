part of 'choose_seller_bloc.dart';

class ChooseSellerState extends Equatable {
  final ChooseSellerStateType type;
  final List<ProfileInfoResponse> sellers;
  final String selectedProfileUid;

  const ChooseSellerState({this.type, this.sellers, this.selectedProfileUid});

  ChooseSellerState copyWith({ChooseSellerStateType type, ProfileInfoResponse sellers, String selectedProfileUid}) {
    return ChooseSellerState(
        type: type ?? this.type,
        sellers: sellers ?? this.sellers,
        selectedProfileUid: selectedProfileUid ?? this.selectedProfileUid);
  }

  @override
  List<Object> get props => [sellers, type, selectedProfileUid];
}

enum ChooseSellerStateType { loading, profiles_fetched, selected_changed }
