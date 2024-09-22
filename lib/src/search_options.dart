import 'package:select_field/select_field.dart';

class SearchOptions<T> {
  /// Height for the every option widget is fixed
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
