part of 'edit_spot_bloc.dart';

class EditSpotFormState extends Equatable {
  final SpotManagementRequest spotManagementRequest;
  const EditSpotFormState({
    this.spotManagementRequest,
  });

  EditSpotFormState copyWith({
    final SpotManagementRequest spotManagementRequest,
  }) {
    return EditSpotFormState(
      spotManagementRequest: spotManagementRequest ?? this.spotManagementRequest,
    );
  }

  bool get isFilled =>
      spotManagementRequest?.name != null &&
      spotManagementRequest?.xcoordinate != null &&
      spotManagementRequest?.name != "";

  @override
  List<Object> get props => [spotManagementRequest];
}
