import 'package:drop_here_mobile/accounts/model/api/company_management_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_api.g.dart';

@JsonSerializable()
class Page {
  List<CompanyCustomerResponse> content;
  bool empty;
  bool first;
  bool last;
  int number;
  int numberOfElements;
  Pageable pageable;
  int size;
  Sort sort;
  int totalElements;
  int totalPages;

  Page();

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);
}

@JsonSerializable()
class Pageable {
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  Sort sort;
  bool unpaged;

  Pageable();

  factory Pageable.fromJson(Map<String, dynamic> json) => _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}

@JsonSerializable()
class Sort {
  bool empty;
  bool sorted;
  bool unsorted;

  Sort();

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);
  Map<String, dynamic> toJson() => _$SortToJson(this);
}
