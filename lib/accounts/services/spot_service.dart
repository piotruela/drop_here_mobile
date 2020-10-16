import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/spots/model/api/spot_management_api.dart';
import 'package:get/get.dart';

class SpotService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<SpotCompanyResponse> fetchSpotDetails(String spotUid) async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/spots/$spotUid", out: (dynamic json) => json);
    return SpotCompanyResponse.fromJson(response);

    // //TODO implement
    // SpotCompanyResponse spotCompanyResponse = SpotCompanyResponse(
    //   createdAt: DateTime.now(),
    //   description: "example: Nie ma opisu bo brak dlugopis",
    //   estimatedRadiusMaters: 200,
    //   hidden: false,
    //   id: 1,
    //   lastUpdatedAt: DateTime.utc(1989, 11, 9),
    //   name: "Ryneczek lidla",
    //   password: "aezakmi",
    //   requiredPassword: false,
    //   requiredAccept: false,
    //   xcoordinate: 25.3,
    //   ycoordinate: 35.2,
    // );
    // return Future.delayed(Duration(milliseconds: 600), () {
    //   return spotCompanyResponse;
    // });
  }
}
