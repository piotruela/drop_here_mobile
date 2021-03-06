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
  final List<CompanyCustomerResponse> clients;
  const ClientsFetched(this.clients);

  @override
  List<Object> get props => [clients];
}

class SellersFetched extends DhListState {
  final List<ProfileInfoResponse> sellers;
  const SellersFetched(this.sellers);

  @override
  List<Object> get props => [sellers];
}

class ProductsFetched extends DhListState {
  final List<ProductResponse> products;
  const ProductsFetched({this.products});

  @override
  List<Object> get props => [products];
}

class ShipmentsFetched extends DhListState {
  final List<ShipmentResponse> shipments;
  const ShipmentsFetched({this.shipments});

  @override
  List<Object> get props => [shipments];
}

class FetchingError extends DhListState {
  final String error;
  const FetchingError(this.error);
  @override
  List<Object> get props => [error];
}
