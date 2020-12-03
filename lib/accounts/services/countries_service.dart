import 'package:drop_here_mobile/accounts/model/api/country_api.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:get/get.dart';

class CountriesService {
  final DhHttpClient _httpClient = Get.find<DhHttpClient>();

  Future<List<Country>> getCountries() async {
    List<dynamic> response = await _httpClient.get(
        canRepeatRequest: true, path: "/countries", out: (dynamic json) => json);
    List<Country> countries = [];
    for (dynamic element in response) {
      countries.add(Country.fromJson(element));
    }
    return countries;
  }
}
