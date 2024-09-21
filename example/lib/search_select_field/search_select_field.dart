import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class SearchSelectField extends StatelessWidget {
  final List<Option<String>> options;

  const SearchSelectField({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return SelectField(
      options: options,
      searchOptions: SearchOptions(),
    );
  }
}
