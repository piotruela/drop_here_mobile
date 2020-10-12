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

  bool isFilled() {
    return spotManagementRequest?.name != null && isPasswordFilled();
  }

  bool isPasswordFilled() {
    if (spotManagementRequest != null) {
      //throws error because requiredPassword is not implemented yet
      if (spotManagementRequest.requiredPassword) {
        return spotManagementRequest?.password != null && spotManagementRequest?.password != '';
      }
    }
    return true;
  }

  @override
  List<Object> get props => [spotManagementRequest];
}
