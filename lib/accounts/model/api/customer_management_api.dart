import 'package:json_annotation/json_annotation.dart';

part 'customer_management_api.g.dart';

@JsonSerializable()
class CustomerManagementRequest {
  final String firstName;
  final String lastName;

  CustomerManagementRequest({this.firstName, this.lastName});

  factory CustomerManagementRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerManagementRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerManagementRequestToJson(this);
}

@JsonSerializable()
class CustomerInfoResponse {
  final String firstName;
  final int id;
  final String lastName;
  final bool registered;

  CustomerInfoResponse({this.firstName, this.id, this.lastName, this.registered});

  factory CustomerInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerInfoResponseToJson(this);

  String get customerFullName => "$firstName $lastName";
}
