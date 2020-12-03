part of 'customer_details_bloc.dart';

abstract class CustomerDetailsEvent {}

class FetchCustomerDetails extends CustomerDetailsEvent {}

class LogOut extends CustomerDetailsEvent {}

class UpdateClientDetails extends CustomerDetailsEvent {
  final String firstName;
  final String lastName;

  UpdateClientDetails({this.firstName, this.lastName});
}
