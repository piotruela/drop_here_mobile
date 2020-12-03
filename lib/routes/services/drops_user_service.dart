import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:get/get.dart';

class DropsUserService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<DropDetailedCustomerResponse> fetchDrop(String dropUid) async {
    dynamic response =
        await _httpClient.get(canRepeatRequest: true, path: "/drops/$dropUid", out: (dynamic json) => json);
    return DropDetailedCustomerResponse.fromJson(response);
  }

}
