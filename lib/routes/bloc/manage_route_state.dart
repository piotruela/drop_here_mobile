part of 'manage_route_bloc.dart';

class ManageRouteState extends Equatable {
  final ManageRouteStateType type;
  final UnpreparedRouteRequest routeRequest;
  final List<ProfileInfoResponse> sellerProfiles;
  final List<ProductResponse> products;

  ManageRouteState({this.type, this.routeRequest, this.sellerProfiles, this.products});

  @override
  List<Object> get props => [type, routeRequest, sellerProfiles, products];

  String get sellerFullName => sellerProfiles
      .firstWhere((element) => element.profileUid == routeRequest.profileUid, orElse: () => null)
      ?.fullName;

/*  List<ProductResponse> get selectedProducts => products
      ?.where((productFromList) =>
          routeRequest?.products?.any((selectedProduct) => productFromList.id == selectedProduct.productId))
      ?.toList();*/
}

enum ManageRouteStateType { initial, loading, form_changed, error, added_successfully }
