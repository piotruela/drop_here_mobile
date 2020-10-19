// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsPage _$ProductsPageFromJson(Map<String, dynamic> json) {
  return ProductsPage()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : ProductResponse.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..empty = json['empty'] as bool
    ..first = json['first'] as bool
    ..last = json['last'] as bool
    ..number = json['number'] as int
    ..numberOfElements = json['numberOfElements'] as int
    ..pageable = json['pageable'] == null
        ? null
        : Pageable.fromJson(json['pageable'] as Map<String, dynamic>)
    ..size = json['size'] as int
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..totalElements = json['totalElements'] as int
    ..totalPages = json['totalPages'] as int;
}

Map<String, dynamic> _$ProductsPageToJson(ProductsPage instance) =>
    <String, dynamic>{
      'content': instance.content,
      'empty': instance.empty,
      'first': instance.first,
      'last': instance.last,
      'number': instance.number,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'size': instance.size,
      'sort': instance.sort,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page()
    ..content = (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : CompanyCustomerResponse.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..empty = json['empty'] as bool
    ..first = json['first'] as bool
    ..last = json['last'] as bool
    ..number = json['number'] as int
    ..numberOfElements = json['numberOfElements'] as int
    ..pageable = json['pageable'] == null
        ? null
        : Pageable.fromJson(json['pageable'] as Map<String, dynamic>)
    ..size = json['size'] as int
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..totalElements = json['totalElements'] as int
    ..totalPages = json['totalPages'] as int;
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'content': instance.content,
      'empty': instance.empty,
      'first': instance.first,
      'last': instance.last,
      'number': instance.number,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'size': instance.size,
      'sort': instance.sort,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

Pageable _$PageableFromJson(Map<String, dynamic> json) {
  return Pageable()
    ..offset = json['offset'] as int
    ..pageNumber = json['pageNumber'] as int
    ..pageSize = json['pageSize'] as int
    ..paged = json['paged'] as bool
    ..sort = json['sort'] == null
        ? null
        : Sort.fromJson(json['sort'] as Map<String, dynamic>)
    ..unpaged = json['unpaged'] as bool;
}

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
      'offset': instance.offset,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'sort': instance.sort,
      'unpaged': instance.unpaged,
    };

Sort _$SortFromJson(Map<String, dynamic> json) {
  return Sort()
    ..empty = json['empty'] as bool
    ..sorted = json['sorted'] as bool
    ..unsorted = json['unsorted'] as bool;
}

Map<String, dynamic> _$SortToJson(Sort instance) => <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };
