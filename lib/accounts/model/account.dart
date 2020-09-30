import 'package:drop_here_mobile/accounts/model/credentials.dart';
import 'package:drop_here_mobile/accounts/model/profile.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  AccountMailStatus accountMailStatus;
  AccountStatus accountStatus;
  AccountType accountType;
  bool anyProfileRegistered;
  DateTime createdAt;
  String mail;
  List<Profile> profiles;

  Account();

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

enum AccountMailStatus { CONFIRMED, UNCONFIRMED }

enum AccountStatus { ACTIVE, INACTIVE }
