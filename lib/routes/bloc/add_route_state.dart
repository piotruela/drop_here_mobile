part of 'add_route_bloc.dart';

class AddRouteFormState extends Equatable {
  final UnpreparedRouteRequest routeRequest;
  final List<LocalDrop> drops;
  final List<LocalProduct> products;
  final String sellerFirstName;
  final String sellerLastName;
  const AddRouteFormState({
    this.routeRequest,
    this.drops,
    this.products,
    this.sellerFirstName,
    this.sellerLastName,
  });

  AddRouteFormState copyWith({
    final UnpreparedRouteRequest routeRequest,
    final List<LocalDrop> drops,
    final List<LocalProduct> products,
    final String sellerFirstName,
    final String sellerLastName,
  }) {
    return AddRouteFormState(
      routeRequest: routeRequest ?? this.routeRequest,
      drops: drops ?? this.drops,
      products: products ?? this.products,
      sellerFirstName: sellerFirstName ?? this.sellerFirstName,
      sellerLastName: sellerLastName ?? this.sellerLastName,
    );
  }

  bool get isFilled =>
      //TODO add more
      routeRequest.name != null && routeRequest.date != null;

  @override
  List<Object> get props =>
      [routeRequest, isFilled, drops, products, sellerFirstName, sellerLastName];

  String sellerFullName() {
    if (sellerFirstName != null && sellerLastName != null) {
      return sellerFirstName + ' ' + sellerLastName;
    }
    return null;
  }
}
