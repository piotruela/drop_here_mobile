part of 'create_profile_bloc.dart';

class CreateProfileState extends Equatable {
  final CreateProfileForm form;

  CreateProfileState({this.form});

  CreateProfileState copyWith({CreateProfileForm form}) {
    return CreateProfileState(form: form ?? this.form);
  }

  @override
  List<Object> get props => [form];
}

class CreateProfileLoadingState extends CreateProfileState {}

class ErrorState extends CreateProfileState {}

class SuccessState extends CreateProfileState {}
