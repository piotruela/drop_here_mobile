import 'package:drop_here_mobile/accounts/services/account_service.dart';
import 'package:drop_here_mobile/accounts/services/authentication_service.dart';
import 'package:drop_here_mobile/accounts/services/company_management_service.dart';
import 'package:drop_here_mobile/accounts/services/countries_service.dart';
import 'package:drop_here_mobile/accounts/services/customer_management_service.dart';
import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/config/assets_config.dart';
import 'package:drop_here_mobile/common/config/theme_config.dart';
import 'package:drop_here_mobile/common/data/http/http_client.dart';
import 'package:drop_here_mobile/config/drop_here_assets_config.dart';
import 'package:drop_here_mobile/config/drop_here_theme_config.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/firebase_push_notifications_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/local_notification_executive_service.dart';
import 'package:drop_here_mobile/notifications/services/executive_service/notification_executive_service_factory.dart';
import 'package:drop_here_mobile/notifications/services/notifications_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/local_notification_push_notification_observer.dart';
import 'package:drop_here_mobile/notifications/services/notifications_configuration_service.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/navigating_click_observer.dart';
import 'package:drop_here_mobile/notifications/services/observer_service/notification_observer_service_factory.dart';
import 'package:drop_here_mobile/products/services/product_management_service.dart';
import 'package:drop_here_mobile/routes/services/route_management_service.dart';
import 'package:drop_here_mobile/spots/services/spot_management_service.dart';
import 'package:drop_here_mobile/spots/services/spots_user_service.dart';
import 'package:get/get.dart';

class ConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsService());
    Get.put(FirebasePushNotificationsExecutiveService());
    Get.put(LocalNotificationExecutiveService());
    Get.put(NotificationExecutiveServiceFactory());
    Get.put(LocalNotificationPopOutObserver());
    Get.put(NavigatingClickObserver());
    Get.put(NotificationObserverFactory());
    Get.put(NotificationsConfigurationService());
    Get.put(AppStorageService());
    Get.put<ThemeConfig>(DHThemeConfig());
    Get.put<AssetsConfig>(DHAssetsConfig());
    Get.put<DhHttpClient>(DhHttpClient());
    Get.put(AccountService());
    Get.put(CountriesService());
    Get.put(AuthenticationService());
    Get.put(CompanyManagementService());
    Get.put(CustomerManagementService());
    Get.put(ProductManagementService());
    Get.put(SpotManagementService());
    Get.put(RouteManagementService());
    Get.put(SpotsUserService());
  }
}
