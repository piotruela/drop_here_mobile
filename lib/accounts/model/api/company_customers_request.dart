class CompanyCustomersRequest {
  bool blocked;
  String customerName;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool sortSorted;
  bool unpaged;

  CompanyCustomersRequest();

  String toQueryParams() {
    return "customerName=${customerName ?? ''}"
        "&blocked=${blocked ?? ''}"
        "&offset=${offset ?? ''}"
        "&pageNumber=${pageNumber ?? ''}"
        "&pageSize=${pageSize ?? ''}"
        "&paged=${paged ?? ''}"
        "&sort.sorted=${sortSorted ?? ''}"
        "&unpaged=${unpaged ?? ''}";
  }
}
