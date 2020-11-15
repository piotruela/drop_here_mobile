part of 'add_spot_bloc.dart';

class AddSpotFormState extends Equatable {
  final SpotManagementRequest spotManagementRequest;
  const AddSpotFormState({
    this.spotManagementRequest,
  });

  AddSpotFormState copyWith({
    final SpotManagementRequest spotManagementRequest,
  }) {
    return AddSpotFormState(
      spotManagementRequest: spotManagementRequest ?? this.spotManagementRequest,
    );
  }

  bool get isFilled =>
      spotManagementRequest.xcoordinate != null &&
      spotManagementRequest.name != null &&
      spotManagementRequest.name != "";

  @override
  List<Object> get props => [spotManagementRequest, isFilled];
}
