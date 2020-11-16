import 'package:json_annotation/json_annotation.dart';

part 'customer_management_api.g.dart';

@JsonSerializable()
class CustomerManagementRequest {
  final String firstName;
  final String lastName;

  CustomerManagementRequest({this.firstName, this.lastName});

  factory CustomerManagementRequest.fromJson(Map<String, dynamic> json) => _$CustomerManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerManagementRequestToJson(this);
}

@JsonSerializable()
class CustomerInfoResponse {
  final bool registered;
  final String firstName;
  final String lastName;

  CustomerInfoResponse({this.registered, this.firstName, this.lastName});

  factory CustomerInfoResponse.fromJson(Map<String, dynamic> json) => _$CustomerInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerInfoResponseToJson(this);

  String get customerFullName => "$firstName $lastName";
}
