import 'package:json_annotation/json_annotation.dart';

part 'company_management_api.g.dart';

enum VisibilityStatus { VISIBLE, HIDDEN }

enum OperationStatus { CREATED, UPDATED, DELETED, ERROR }

enum RelationshipStatus { ACTIVE, BLOCKED }

enum MembershipStatus { ACTIVE, PENDING, BLOCKED }

@JsonSerializable()
class Company {
  String country;
  String name;
  int profilesCount;
  bool registered;
  String uid;
  VisibilityStatus visibilityStatus;

  Company();

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class CompanyManagementRequest {
  @JsonKey(name: 'name')
  final String companyName;
  @JsonKey(name: 'country')
  final String countryName;
  @JsonKey(name: 'visibilityStatus')
  final String visibility;

  CompanyManagementRequest({this.companyName, this.countryName, this.visibility});

  factory CompanyManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$CompanyManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyManagementRequestToJson(this);

  CompanyManagementRequest copyWith({String companyName, String countryName, String visibility}) {
    return CompanyManagementRequest(
        companyName: companyName ?? this.companyName,
        countryName: countryName ?? this.countryName,
        visibility: visibility ?? this.visibility);
  }
}

@JsonSerializable()
class CompanyCustomerManagementRequest {
  bool block;

  CompanyCustomerManagementRequest({bool block});

  factory CompanyCustomerManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$CompanyCustomerManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyCustomerManagementRequestToJson(this);

  CompanyCustomerManagementRequest copyWith({bool block}) {
    return CompanyCustomerManagementRequest(block: block ?? this.block);
  }
}

@JsonSerializable()
class ResourceOperationResponse {
  int id;
  OperationStatus operationStatus;

  ResourceOperationResponse();

  factory ResourceOperationResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceOperationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceOperationResponseToJson(this);
}

@JsonSerializable()
class CompanyCustomerResponse {
  int customerId;
  String firstName;
  String lastName;
  RelationshipStatus relationshipStatus;

  CompanyCustomerResponse();

  factory CompanyCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyCustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyCustomerResponseToJson(this);
}

@JsonSerializable()
class CompanyCustomerSpotMembershipResponse {
  MembershipStatus membershipStatus;
  int spotId;
  String spotName;
  String spotUid;

  CompanyCustomerSpotMembershipResponse();

  factory CompanyCustomerSpotMembershipResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyCustomerSpotMembershipResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyCustomerSpotMembershipResponseToJson(this);
}
