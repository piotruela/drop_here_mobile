part of 'drop_details_bloc.dart';

abstract class DropDetailsEvent extends Equatable {}

class FetchDropDetails extends DropDetailsEvent {
  final String dropUid;

  FetchDropDetails({this.dropUid});

  @override
  List<Object> get props => [dropUid];
}
