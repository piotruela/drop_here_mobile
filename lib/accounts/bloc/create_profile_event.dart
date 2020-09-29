part of 'create_profile_bloc.dart';

abstract class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends CreateProfileEvent {
  final CreateProfileForm form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends CreateProfileEvent {
  final bool isValid;
  final CreateProfileForm form;

  FormSubmitted({this.isValid, this.form});

  @override
  List<Object> get props => [form, isValid];
}
