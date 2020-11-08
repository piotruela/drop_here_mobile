import 'package:drop_here_mobile/spots/bloc/spot_details_bloc.dart';
import 'package:drop_here_mobile/spots/ui/pages/customer_map_page.dart';
import 'package:get/get.dart';

import 'notification_observer_service.dart';

class NavigatingClickObserver extends NotificationObserver {
  //todo macias - check czy jest zalogowany jeszcze
  @override
  Future<void> handleNotification(NotificationPayload payload) {
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

  Future<void> handleSpotNotification(NotificationPayload payload) {
    return Get.to(CustomerMapPage(
        spotDetailsOnLoadEvent: new FetchSpotDetailsEvent(spotUid: payload.referencedSubjectId)));
  }

  Future<void> _handleClickedNotification(NotificationPayload payload) {
    switch (payload.referencedSubjectType) {
      case ReferencedSubjectType.DROP:
        //todo przekierowanie na drop (np. gdy zmienił status - notyfikacje do klienta)
      case ReferencedSubjectType.SHIPMENT:
        //todo przekierowanie na shipment
        break;
      case ReferencedSubjectType.SPOT:
        return handleSpotNotification(payload);
      case ReferencedSubjectType.UNKNOWN:
      case ReferencedSubjectType.EMPTY:
      default:
        break;
    }
    return Future.value();
  }
}
