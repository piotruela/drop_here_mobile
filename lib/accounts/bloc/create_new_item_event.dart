part of 'create_new_item_bloc.dart';

@immutable
abstract class CreateNewItemEvent extends Equatable {
  const CreateNewItemEvent();
}

class CreateNewProduct extends CreateNewItemEvent {
  const CreateNewProduct();

  @override
  List<Object> get props => [];
}

class CreateNewSpot extends CreateNewItemEvent {
  const CreateNewSpot();

  @override
  List<Object> get props => [];
}

class CreateNewRoute extends CreateNewItemEvent {
  const CreateNewRoute();

  @override
  List<Object> get props => [];
}

class CreateNewProfile extends CreateNewItemEvent {
  const CreateNewProfile();

  @override
  List<Object> get props => [];
}
