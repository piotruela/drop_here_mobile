import 'package:json_annotation/json_annotation.dart';

part 'create_profile_form.g.dart';

@JsonSerializable()
class CreateProfileForm {
  final String firstName;
  final String lastName;
  final String password;

  CreateProfileForm({this.firstName, this.lastName, this.password});

  factory CreateProfileForm.fromJson(Map<String, dynamic> json) =>
      _$CreateProfileFormFromJson(json);
  Map<String, dynamic> toJson() => _$CreateProfileFormToJson(this);

  CreateProfileForm copyWith({String firstName, String lastName, String password}) {
    return CreateProfileForm(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password);
  }
}
