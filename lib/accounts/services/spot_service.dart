import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';

class SpotService {
  Future<SpotCompanyResponse> fetchSpotDetails() {
    //TODO implement
    SpotCompanyResponse spotCompanyResponse = SpotCompanyResponse(
      createdAt: DateTime.now(),
      description: "example: Nie ma opisu bo brak dlugopis",
      estimatedRadiusMaters: 200,
      hidden: false,
      id: 1,
      lastUpdatedAt: DateTime.utc(1989, 11, 9),
      name: "Ryneczek lidla",
      password: "aezakmi",
      requiredPassword: false,
      requiredAccept: false,
      xcoordinate: 25.3,
      ycoordinate: 35.2,
    );
    return Future.delayed(Duration(milliseconds: 600), () {
      return spotCompanyResponse;
    });
  }
}
