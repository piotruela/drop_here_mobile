import 'package:json_annotation/json_annotation.dart';

part 'country_api.g.dart';

@JsonSerializable()
class Country {
  String name;
  String mobilePrefix;

  Country();

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}
