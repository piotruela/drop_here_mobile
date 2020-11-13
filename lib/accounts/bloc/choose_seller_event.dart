part of 'choose_seller_bloc.dart';

abstract class ChooseSellerEvent extends Equatable {
  const ChooseSellerEvent();
}

class InitializePage extends ChooseSellerEvent {
  final String selectedSellerUid;

  const InitializePage({this.selectedSellerUid});
  @override
  List<Object> get props => [selectedSellerUid];
}

class ChooseSeller extends ChooseSellerEvent {
  final String sellerUid;

  ChooseSeller({this.sellerUid});

  @override
  List<Object> get props => [sellerUid];
}
