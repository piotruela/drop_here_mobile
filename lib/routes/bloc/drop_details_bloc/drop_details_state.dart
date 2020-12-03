part of 'drop_details_bloc.dart';

class DropDetailsState extends Equatable {
  final DropDetailsStateType type;
  final DropDetailedCustomerResponse drop;

  DropDetailsState({this.type, this.drop});

  @override
  List<Object> get props => [type, drop];
}

enum DropDetailsStateType { loading, error, fetched }
