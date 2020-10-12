import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/api/page_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spot_management_api.g.dart';

@JsonSerializable()
class SpotManagementRequest {
  final String description;
  final int estimatedRadiusMaters;
  final bool hidden;
  final String name;
  final String password;
  final bool requiredAccept;
  final bool requiredPassword;
  final double xcoordinate;
  final double ycoordinate;

  SpotManagementRequest(
      {this.description,
      this.estimatedRadiusMaters,
      this.hidden,
      this.name,
      this.password,
      this.requiredAccept,
      this.requiredPassword,
      this.xcoordinate,
      this.ycoordinate});

  factory SpotManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$SpotManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SpotManagementRequestToJson(this);

  SpotManagementRequest copyWith({
    String description,
    int estimatedRadiusMaters,
    bool hidden,
    String name,
    String password,
    bool requiredAccept,
    bool requiredPassword,
    double xcoordinate,
    double ycoordinate,
  }) {
    return SpotManagementRequest(
      description: description ?? this.description,
      estimatedRadiusMaters: estimatedRadiusMaters ?? this.estimatedRadiusMaters,
      hidden: hidden ?? this.hidden,
      name: name ?? this.name,
      password: password ?? this.password,
      requiredAccept: requiredAccept ?? this.requiredAccept,
      requiredPassword: requiredPassword ?? this.requiredPassword,
      xcoordinate: xcoordinate ?? this.xcoordinate,
      ycoordinate: ycoordinate ?? this.ycoordinate,
    );
  }
}

@JsonSerializable()
class SpotCompanyResponse {
  final DateTime createdAt;
  final String description;
  final int estimatedRadiusMaters;
  final bool hidden;
  final int id;
  final DateTime lastUpdatedAt;
  final String name;
  final String password;
  final bool requiredAccept;
  final bool requiredPassword;
  final double xcoordinate;
  final double ycoordinate;

  SpotCompanyResponse(
      {this.createdAt,
      this.id,
      this.lastUpdatedAt,
      this.description,
      this.estimatedRadiusMaters,
      this.hidden,
      this.name,
      this.password,
      this.requiredAccept,
      this.requiredPassword,
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
