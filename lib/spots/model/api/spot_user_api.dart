import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:drop_here_mobile/routes/model/api/drop_customer_spot_response_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'spot_user_api.g.dart';

class SpotCustomerRequest {
  final bool member;
  final String namePrefix;
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final int radius;
  final bool sortSorted;
  final bool sortUnsorted;
  final bool unpaged;
  final double xCoordinate;
  final double yCoordinate;

  SpotCustomerRequest(
      {this.member,
      this.namePrefix,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.radius,
      this.sortSorted,
      this.sortUnsorted,
      this.unpaged,
      this.xCoordinate,
      this.yCoordinate});

  String toQueryParams() {
    return "member=${member ?? ''}"
        "&namePrefix=${namePrefix ?? ''}"
        "&offset=${offset ?? ''}"
        "&pageNumber=${pageNumber ?? ''}"
        "&pageSize=${pageSize ?? ''}"
        "&paged=${paged ?? ''}"
        "&radius=${radius ?? ''}"
        "&sort.sorted=${sortSorted ?? ''}"
        "&sort.unsorted=${sortUnsorted ?? ''}"
        "&unpaged=${unpaged ?? ''}"
        "&xCoordinate=${xCoordinate ?? ''}"
        "&yCoordinate=${yCoordinate ?? ''}";
  }
}

@JsonSerializable()
class SpotBaseCustomerResponse {
  String companyName;
  String companyUid;
  String description;
  int estimatedRadiusMeters;
  MembershipStatus membershipStatus;
  String name;
  bool receiveCancelledNotifications;
  bool receiveDelayedNotifications;
  bool receiveFinishedNotifications;
  bool receiveLiveNotifications;
  bool receivePreparedNotifications;
  bool requiresAccept;
  bool requiresPassword;
  String uid;
  double xcoordinate;
  double ycoordinate;

  SpotBaseCustomerResponse();

  factory SpotBaseCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$SpotBaseCustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpotBaseCustomerResponseToJson(this);
}

@JsonSerializable()
class SpotDetailedCustomerResponse {
  final List<DropCustomerSpotResponse> drops;
  final SpotBaseCustomerResponse spot;

  SpotDetailedCustomerResponse({this.drops, this.spot});

  factory SpotDetailedCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$SpotDetailedCustomerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpotDetailedCustomerResponseToJson(this);
}
