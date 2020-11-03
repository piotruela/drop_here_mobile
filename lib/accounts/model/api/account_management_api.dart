import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/accounts/model/seller.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_management_api.g.dart';

enum AccountType { CUSTOMER, COMPANY }

enum ProfileType { MAIN, SUBPROFILE }

enum AccountMailStatus { CONFIRMED, UNCONFIRMED }

enum AccountStatus { ACTIVE, INACTIVE }

@JsonSerializable()
class AccountInfoResponse {
  AccountMailStatus accountMailStatus;
  AccountStatus accountStatus;
  AccountType accountType;
  bool anyProfileRegistered;
  DateTime createdAt;
  String mail;
  List<ProfileInfoResponse> profiles;

  AccountInfoResponse();

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AccountInfoResponseToJson(this);
}

@JsonSerializable()
class ProfileInfoResponse {
  String firstName;
  String lastName;
  ProfileType profileType;
  String profileUid;
  AccountStatus status;

  ProfileInfoResponse();

  Seller convertFromApiModel() =>
      Seller(name: this.firstName, surname: this.lastName, status: toMembershipStatus());

  MembershipStatus toMembershipStatus() {
    switch (this.status) {
      case AccountStatus.ACTIVE:
        return MembershipStatus.ACTIVE;
        break;
      case AccountStatus.INACTIVE:
        return MembershipStatus.BLOCKED;
        break;
      default:
        return null;
    }
  }

  ProfileInfoResponse.withName({String firstName, String lastName, ProfileType profileType}) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.profileType = profileType;
  }

  bool isAdmin() => profileType == ProfileType.MAIN;

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfoResponseToJson(this);

  String get sellerFullName => "$firstName $lastName";
}

@JsonSerializable()
class AccountCreationRequest {
  final AccountType accountType;
  final String mail;
  final String password;

  AccountCreationRequest({this.accountType, this.mail, this.password});

  factory AccountCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountCreationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AccountCreationRequestToJson(this);

  AccountCreationRequest copyWith({AccountType accountType, String mail, String password}) {
    return AccountCreationRequest(
        accountType: accountType ?? this.accountType,
        mail: mail ?? this.mail,
        password: password ?? this.password);
  }
}

@JsonSerializable()
class AccountProfileCreationRequest {
  final String firstName;
  final String lastName;
  final String password;

  AccountProfileCreationRequest({this.firstName, this.lastName, this.password});

  factory AccountProfileCreationRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountProfileCreationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AccountProfileCreationRequestToJson(this);

  AccountProfileCreationRequest copyWith({String firstName, String lastName, String password}) {
    return AccountProfileCreationRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password);
  }
}

@JsonSerializable()
class AccountProfileUpdateRequest {
  final String firstName;
  final String lastName;

  AccountProfileUpdateRequest(this.firstName, this.lastName);

  factory AccountProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountProfileUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AccountProfileUpdateRequestToJson(this);
}
