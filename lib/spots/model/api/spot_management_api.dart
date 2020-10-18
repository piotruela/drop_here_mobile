import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/page_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spot_management_api.g.dart';

@JsonSerializable()
class SpotManagementRequest {
  final String description;
  final int estimatedRadiusMeters;
  final bool hidden;
  final String name;
  final String password;
  final bool requiresAccept;
  final bool requiresPassword;
  final double xcoordinate;
  final double ycoordinate;

  SpotManagementRequest(
      {this.description,
      this.estimatedRadiusMeters,
      this.hidden,
      this.name,
      this.password,
      this.requiresAccept,
      this.requiresPassword,
      this.xcoordinate,
      this.ycoordinate});

  factory SpotManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$SpotManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SpotManagementRequestToJson(this);

  SpotManagementRequest copyWith({
    String description,
    int estimatedRadiusMeters,
    bool hidden,
    String name,
    String password,
    bool requiresAccept,
    bool requiresPassword,
    double xcoordinate,
    double ycoordinate,
    bool passwordNull = false,
    bool nameNull = false,
    bool coordsNull = false,
  }) {
    return SpotManagementRequest(
      description: description ?? this.description,
      estimatedRadiusMeters: estimatedRadiusMeters ?? this.estimatedRadiusMeters,
      hidden: hidden ?? this.hidden,
      name: nameNull ? null : name ?? this.name,
      password: passwordNull ? null : password ?? this.password,
      requiresAccept: requiresAccept ?? this.requiresAccept,
      requiresPassword: requiresPassword ?? this.requiresPassword,
      xcoordinate: coordsNull ? null : xcoordinate ?? this.xcoordinate,
      ycoordinate: coordsNull ? null : ycoordinate ?? this.ycoordinate,
    );
  }
}

@JsonSerializable()
class SpotCompanyResponse {
  final DateTime createdAt;
  final String description;
  final int estimatedRadiusMeters;
  final bool hidden;
  final int id;
  final DateTime lastUpdatedAt;
  final String name;
  final String password;
  final bool requiresAccept;
  final bool requiresPassword;
  final double xcoordinate;
  final double ycoordinate;

  LatLng get coords => LatLng(xcoordinate, ycoordinate);

  SpotManagementRequest get toRequest => SpotManagementRequest(
      name: this.name,
      description: this.description,
      estimatedRadiusMeters: this.estimatedRadiusMeters,
      hidden: this.hidden,
      requiresPassword: this.requiresPassword,
      requiresAccept: this.requiresAccept,
      password: this.password,
      xcoordinate: this.xcoordinate,
      ycoordinate: this.ycoordinate);

  SpotCompanyResponse(
      {this.createdAt,
      this.id,
      this.lastUpdatedAt,
      this.description,
      this.estimatedRadiusMeters,
      this.hidden,
      this.name,
      this.password,
      this.requiresAccept,
      this.requiresPassword,
      this.xcoordinate,
      this.ycoordinate});

  factory SpotCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$SpotCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpotCompanyResponseToJson(this);
}

@JsonSerializable()
class SpotMembershipPage {
  List<SpotCompanyMembershipResponse> content;
  bool empty;
  bool first;
  bool last;
  int number;
  int numberOfElements;
  Pageable pageable;
  int size;
  Sort sort;
  int totalElements;
  int totalPages;

  SpotMembershipPage();

  factory SpotMembershipPage.fromJson(Map<String, dynamic> json) =>
      _$SpotMembershipPageFromJson(json);
  Map<String, dynamic> toJson() => _$SpotMembershipPageToJson(this);
}

@JsonSerializable()
class SpotCompanyMembershipResponse {
  final int customerId;
  final String firstName;
  final String lastName;
  final MembershipStatus membershipStatus;

  SpotCompanyMembershipResponse(
      {this.customerId, this.firstName, this.lastName, this.membershipStatus});

  factory SpotCompanyMembershipResponse.fromJson(Map<String, dynamic> json) =>
      _$SpotCompanyMembershipResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpotCompanyMembershipResponseToJson(this);
}

@JsonSerializable()
class SpotCompanyMembershipManagementRequest {
  final MembershipStatus membershipStatus;

  SpotCompanyMembershipManagementRequest({this.membershipStatus});

  factory SpotCompanyMembershipManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$SpotCompanyMembershipManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SpotCompanyMembershipManagementRequestToJson(this);
}
