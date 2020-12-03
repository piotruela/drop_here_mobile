import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';

class Client {
  final String name;
  final MembershipStatus status;
  final int numberOfDropsMember;

  const Client({this.status, this.numberOfDropsMember, this.name});
}
