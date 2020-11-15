part of 'create_new_item_bloc.dart';

@immutable
abstract class CreateNewItemState extends Equatable {
  const CreateNewItemState();
}

class CreateNewItemInitial extends CreateNewItemState {
  const CreateNewItemInitial();

  @override
  List<Object> get props => [];
}
