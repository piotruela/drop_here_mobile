part of 'create_profile_bloc.dart';

abstract class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();

  @override
  List<Object> get props => [];
}

class FormChanged extends CreateProfileEvent {
  final AccountProfileCreationRequest form;

  FormChanged({this.form});

  @override
  List<Object> get props => [form];
}

class FormSubmitted extends CreateProfileEvent {
  final bool isValid;
  final AccountProfileCreationRequest form;
  final ProfileRole profileRole;

  FormSubmitted({this.isValid, this.form, this.profileRole});

  @override
  List<Object> get props => [form, isValid];
}

enum ProfileRole { ADMIN, BASIC }
