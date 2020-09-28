import 'package:json_annotation/json_annotation.dart';

part 'company_register_details_api.g.dart';

@JsonSerializable()
class CompanyDetails {
  @JsonKey(name: 'name')
  final String companyName;
  @JsonKey(name: 'country')
  final String countryName;
  @JsonKey(name: 'visibilityStatus')
  final bool visibility;

  CompanyDetails({this.companyName, this.countryName, this.visibility});

  factory CompanyDetails.fromJson(Map<String, dynamic> json) => _$CompanyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyDetailsToJson(this);

  CompanyDetails copyWith({String companyName, String countryName, bool visibility}) {
    return CompanyDetails(
        companyName: companyName ?? this.companyName,
        countryName: countryName ?? this.countryName,
        visibility: visibility ?? this.visibility);
  }
}
