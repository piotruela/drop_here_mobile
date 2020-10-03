part of 'choose_profile_bloc.dart';

@immutable
abstract class ChooseProfileState {}

class ChooseProfileInitial extends ChooseProfileState {}

class LoadingState extends ChooseProfileState {}

class ProfilesFetched extends ChooseProfileState {
  final List<ProfileInfoResponse> profiles;

  ProfilesFetched(this.profiles);
}
