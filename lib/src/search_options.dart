class SearchOptions {
  /// Height for the every option widget is fixed
  final double height;

  /// Prefer [SearchBy.label] because it is a string.
  /// If you use [SearchBy.value], value is converted to string, and it is not
  /// as effective
  final SearchBy searchBy;

  SearchOptions({
    this.height = 60,
    this.searchBy = SearchBy.label,
  });
}

enum SearchBy {
  label,
  value,
}
