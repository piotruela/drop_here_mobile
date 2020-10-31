import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';

class Seller {
  final String name;
  final String surname;
  final MembershipStatus status;

  Seller({this.name, this.surname, this.status});

  String get fullName => "$name $surname";
}
