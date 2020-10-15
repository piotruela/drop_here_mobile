part of 'edit_spot_bloc.dart';

class EditSpotFormState extends Equatable {
  final SpotManagementRequest spotManagementRequest;
  final File locationMap;
  const EditSpotFormState({
    this.spotManagementRequest,
    this.locationMap,
  });

  EditSpotFormState copyWith({
    final SpotManagementRequest spotManagementRequest,
    final File locationMap,
  }) {
    return EditSpotFormState(
      locationMap: locationMap ?? this.locationMap,
      spotManagementRequest: spotManagementRequest ?? this.spotManagementRequest,
    );
  }

  bool isFilled() {
    return spotManagementRequest?.name != null &&
        spotManagementRequest?.xcoordinate != null &&
        spotManagementRequest?.ycoordinate != null;
  }

  @override
  List<Object> get props => [spotManagementRequest, locationMap];
}
