// To parse this JSON data, do
//
//     final listResponse = listResponseFromJson(jsonString);

import 'dart:convert';


ListResponse listResponseFromJson(String str, Function f) => ListResponse.fromJson(json.decode(str), f);

String listResponseToJson(ListResponse data) => json.encode(data.toJson());

class ListResponse<T> {
  ListResponse({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  List<T>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  factory ListResponse.fromJson(Map<String, dynamic> json, Function f) => ListResponse<T>(
    content: List<T>.from(json["content"].map((x) => f(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    last: json["last"],
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": content?.map((x) => x).toList(),
    "pageable": pageable?.toJson(),
    "last": last,
    "totalPages": totalPages,
    "totalElements": totalElements,
    "size": size,
    "number": number,
    "sort": sort?.toJson(),
    "first": first,
    "numberOfElements": numberOfElements,
    "empty": empty,
  };
}

class Pageable {
  Pageable({
    this.sort,
    this.offset,
    this.pageSize,
    this.pageNumber,
    this.unpaged,
    this.paged,
  });

  Sort? sort;
  int? offset;
  int? pageSize;
  int? pageNumber;
  bool? unpaged;
  bool? paged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    pageSize: json["pageSize"],
    pageNumber: json["pageNumber"],
    unpaged: json["unpaged"],
    paged: json["paged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort?.toJson(),
    "offset": offset,
    "pageSize": pageSize,
    "pageNumber": pageNumber,
    "unpaged": unpaged,
    "paged": paged,
  };
}

class Sort {
  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  bool? empty;
  bool? sorted;
  bool? unsorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    empty: json["empty"],
    sorted: json["sorted"],
    unsorted: json["unsorted"],
  );

  Map<String, dynamic> toJson() => {
    "empty": empty,
    "sorted": sorted,
    "unsorted": unsorted,
  };
}
