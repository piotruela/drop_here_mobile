import 'package:drop_here_mobile/routes/model/route_request_api.dart';

class LocalDrop extends RouteDropRequest {
  String spotName;
  LocalDrop(RouteDropRequest routeDropRequest, this.spotName)
      : super(
          description: routeDropRequest.description,
          name: routeDropRequest.name,
          startTime: routeDropRequest.startTime,
          endTime: routeDropRequest.endTime,
          spotId: routeDropRequest.spotId,
        );
  LocalDrop copyWith({
    String description,
    String endTime,
    String name,
    int spotId,
    String startTime,
  }) {
    return LocalDrop(
      RouteDropRequest(
          spotId: spotId ?? this.spotId,
          description: description ?? this.description,
          name: name ?? this.name,
          startTime: startTime ?? this.startTime,
          endTime: endTime ?? this.endTime),
      spotName,
    );
  }
}
