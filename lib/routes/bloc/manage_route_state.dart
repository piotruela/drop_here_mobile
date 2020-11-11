part of 'manage_route_bloc.dart';

class ManageRouteState extends Equatable {
  final ManageRouteStateType type;
  final UnpreparedRouteRequest routeRequest;
  final List<ProfileInfoResponse> sellerProfiles;
  final List<ProductResponse> products;
  final List<SpotCompanyResponse> spots;

  ManageRouteState({this.type, this.routeRequest, this.sellerProfiles, this.products, this.spots});

  @override
  List<Object> get props => [type, routeRequest, sellerProfiles, products, spots];

  String get sellerFullName => sellerProfiles
      .firstWhere((element) => element.profileUid == routeRequest.profileUid, orElse: () => null)
      ?.fullName;

  bool get isFilled => routeRequest.name != null && routeRequest.name != "" && routeRequest.date != null;
}

enum ManageRouteStateType { initial, loading, form_changed, error, added_successfully }
