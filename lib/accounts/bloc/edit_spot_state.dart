part of 'edit_spot_bloc.dart';

class EditSpotFormState extends Equatable {
  final SpotManagementRequest spotManagementRequest;
  final File photo;
  const EditSpotFormState({
    this.spotManagementRequest,
    this.photo,
  });

  EditSpotFormState copyWith({
    final SpotManagementRequest spotManagementRequest,
    final File photo,
  }) {
    return EditSpotFormState(
      photo: photo ?? this.photo,
      spotManagementRequest: spotManagementRequest ?? this.spotManagementRequest,
    );
  }

  bool isFilled() {
    return spotManagementRequest?.name != null &&
        spotManagementRequest?.xcoordinate != null &&
        spotManagementRequest?.ycoordinate != null;
  }

  @override
  List<Object> get props => [spotManagementRequest, photo];
}
