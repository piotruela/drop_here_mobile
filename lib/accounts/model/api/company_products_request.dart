class CompanyProductsRequest {
  List<String> category;
  String name;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool sortSorted;
  bool sortUnsorted;
  bool unpaged;

  CompanyProductsRequest();

  String toQueryParams() {
    return "?name=${name ?? ''}"
        "${categoryToQueryParams()}"
        "&offset=${offset ?? ''}"
        "&pageNumber=${pageNumber ?? ''}"
        "&pageSize=${pageSize ?? ''}"
        "&paged=${paged ?? ''}"
        "&sort.sorted=${sortSorted ?? ''}"
        "&sort.unsorted=${sortUnsorted ?? ''}"
        "&unpaged=${unpaged ?? ''}";
  }

  String categoryToQueryParams() {
    if (category == null) return '';
    String params = '';
    for (String categoryElement in category) {
      params += "&category=$categoryElement";
    }
    return params;
  }
}
