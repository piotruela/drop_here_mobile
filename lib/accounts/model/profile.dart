import 'package:drop_here_mobile/accounts/model/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  String firstName;
  String lastName;
  ProfileType profileType;
  String profileUid;
  AccountStatus status;

  Profile();

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

enum ProfileType { MAIN, SUBPROFILE }
