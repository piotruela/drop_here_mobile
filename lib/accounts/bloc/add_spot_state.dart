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
      spotManagementRequest?.name != '' && spotManagementRequest.xcoordinate != null;

  @override
  List<Object> get props => [spotManagementRequest, isFilled];
}
