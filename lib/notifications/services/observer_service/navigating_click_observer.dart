import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/spots/bloc/spot_details_bloc.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:get/get.dart';

import 'notification_observer_service.dart';

class NavigatingClickObserver extends NotificationObserver {

  @override
  Future<void> handleNotification(NotificationPayload payload) {
    if (!Get.find<AppStorageService>().authenticated) {
      return Future.value();
    }
    if (_clicked(payload)) {
      return _handleClickedNotification(payload);
    }
    return Future.value();
  }

  bool _clicked(NotificationPayload payload) {
    return payload.notificationType == NotificationType.CLICKED_APP_BACKGROUND ||
        payload.notificationType == NotificationType.CLICKED_VIEW_NOT_DEFINED ||
        payload.notificationType == NotificationType.CLICKED_APP_TERMINATED;
  }

  Future<void> _handleSpotNotification(NotificationPayload payload) {
    return Get.to(CustomerMapPage(
        spotDetailsOnLoadEvent: new FetchSpotDetailsEvent(spotUid: payload.referencedSubjectId)), preventDuplicates: false);
  }

  Future<void> _handleClickedNotification(NotificationPayload payload) {
    switch (payload.referencedSubjectType) {
      case ReferencedSubjectType.DROP:
      //todo piotruela przekierowanie na drop (np. gdy zmienił status - notyfikacje do klienta)
      case ReferencedSubjectType.SHIPMENT:
        //todo piotruela przekierowanie na shipment (dla firmy i klienta)
        break;
      case ReferencedSubjectType.SPOT:
        return _handleSpotNotification(payload);
      case ReferencedSubjectType.UNKNOWN:
      case ReferencedSubjectType.EMPTY:
      default:
        break;
    }
    return Future.value();
  }
}
