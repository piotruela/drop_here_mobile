import 'package:drop_here_mobile/routes/model/route_request_api.dart';

class LocalDrop extends RouteDropRequest {
  final String spotName;
  LocalDrop(RouteDropRequest routeDropRequest, this.spotName)
      : super(
          description: routeDropRequest.description,
          name: routeDropRequest.name,
          startTime: routeDropRequest.startTime,
          endTime: routeDropRequest.endTime,
          spotId: routeDropRequest.spotId,
        );
}
