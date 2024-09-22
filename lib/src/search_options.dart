import 'package:select_field/select_field.dart';

class SearchOptions<T> {
  /// Height is fixed for every option widget
  final double height;

  /// The default filtering function is:
  /// ```dart
  /// (option, query) => option.label.toLowerCase().contains(query.toLowerCase());
  /// ```
  final bool Function(Option<T> option, String query)? filterBy;

  SearchOptions({
    this.height = 60,
    this.filterBy,
  });
}
