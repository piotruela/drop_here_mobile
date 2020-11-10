part of 'create_order_bloc.dart';

class CreateOrderState extends Equatable {
  final CreateOrderStateType type;
  const CreateOrderState(this.type);
  @override
  List<Object> get props => [type];
}

enum CreateOrderStateType {
  initial,
  form_updated,
}
