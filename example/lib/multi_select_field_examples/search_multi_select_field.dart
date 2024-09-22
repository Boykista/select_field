import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class SearchMultiSelectField extends StatelessWidget {
  final List<Option<String>> options;

  const SearchMultiSelectField({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectField(
      options: options,
      fieldText: 'Search fruit',
      searchOptions: SearchOptions(),
    );
  }
}
