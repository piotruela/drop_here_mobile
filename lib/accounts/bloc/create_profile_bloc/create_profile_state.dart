part of 'create_profile_bloc.dart';

class CreateProfileState extends Equatable {
  final AccountProfileCreationRequest form;

  CreateProfileState({this.form});

  CreateProfileState copyWith({AccountProfileCreationRequest form}) {
    return CreateProfileState(form: form ?? this.form);
  }

  @override
  List<Object> get props => [form];
}

class LoadingState extends CreateProfileState {}

class ErrorState extends CreateProfileState {
  final AccountProfileCreationRequest form;

  ErrorState({this.form});
}

class SuccessState extends CreateProfileState {}
