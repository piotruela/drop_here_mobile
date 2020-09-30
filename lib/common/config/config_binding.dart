import 'package:drop_here_mobile/accounts/services/implementation/dh_account_service.dart';
import 'package:drop_here_mobile/accounts/services/implementation/dh_countries_service.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/config/drop_here_assets_config.dart';
import 'package:drop_here_mobile/config/drop_here_theme_config.dart';
import 'package:get/get.dart';

class ConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeConfig>(() => DHThemeConfig());
    Get.lazyPut<AssetsConfig>(() => DHAssetsConfig());
    Get.put<DhHttpClient>(DhHttpClient());
    Get.put(DropHereAccountService());
    Get.put(DHCountriesService());
  }
}
