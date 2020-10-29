import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/spots/model/api/spot_user_api.dart';
import 'package:get/get.dart';

class SpotsUserService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<List<SpotBaseCustomerResponse>> getSpots(SpotCustomerRequest spotCustomerRequest) async {
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true,
        path: "/spots?${spotCustomerRequest?.toQueryParams() ?? ''}",
        out: (dynamic json) => json);
    return response.map((element) => SpotBaseCustomerResponse.fromJson(element)).toList();
  }

  Future<SpotDetailedCustomerResponse> getSpotDetails(String spotUid) async {
    dynamic response = await _httpClient.get(
        canRepeatRequest: true, path: "/spots/$spotUid", out: (dynamic json) => json);
    return SpotDetailedCustomerResponse.fromJson(response);
  }
}
