import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:drop_here_mobile/shipments/model/api/company_shipment_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_shipment_request.g.dart';

class CompanyShipmentRequest {
  final String dropUid;
  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final int routeId;
  final bool sortSorted;
  final bool sortUnsorted;
  final ShipmentStatus status;
  final bool unpaged;

  CompanyShipmentRequest(
      {this.dropUid,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.routeId,
      this.sortSorted,
      this.sortUnsorted,
      this.unpaged,
      this.status});

  String toQueryParams() {
    return "&dropUid=${dropUid ?? ''}"
        "&offset=${offset ?? ''}"
        "&pageNumber=${pageNumber ?? ''}"
        "&pageSize=${pageSize ?? ''}"
        "&paged=${paged ?? ''}"
        "&routeId=${routeId ?? ''}"
        "&sort.sorted=${sortSorted ?? ''}"
        "&sort.unsorted=${sortUnsorted ?? ''}"
        "&status=${status != null ? describeEnum(status) : ''}"
        "&unpaged=${unpaged ?? ''}";
  }
}

@JsonSerializable()
class ShipmentDecisionRequest {
  String comment;
  Decision companyDecision;

  ShipmentDecisionRequest({this.comment, this.companyDecision});

  factory ShipmentDecisionRequest.fromJson(Map<String, dynamic> json) => _$ShipmentDecisionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ShipmentDecisionRequestToJson(this);
}

enum Decision { REJECT, ACCEPT, CANCEL, DELIVER }
