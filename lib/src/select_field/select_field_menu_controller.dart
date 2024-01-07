import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class SelectFieldMenuController<T> {
  late ValueNotifier<bool> _isExpandedNotifier;
  late ValueNotifier<Option<T>?> _selectedOptionNotifier;

  SelectFieldMenuController({
    bool isExpanded = false,
    Option<T>? initalOption,
  }) {
    _isExpandedNotifier = ValueNotifier(isExpanded);
    _selectedOptionNotifier = ValueNotifier(initalOption);
  }

  set isExpanded(bool value) {
    _isExpandedNotifier.value = value;
  }

  set selectedOption(Option<T>? option) {
    _selectedOptionNotifier.value = option;
  }

  bool get isExpanded => _isExpandedNotifier.value;

  Option<T>? get selectedOption => _selectedOptionNotifier.value;

  void addListener(void Function() onChanged) {
    _isExpandedNotifier.addListener(() {
      onChanged();
    });
    _selectedOptionNotifier.addListener(() {
      onChanged();
    });
  }

  void dispose() {
    _isExpandedNotifier.dispose();
    _selectedOptionNotifier.dispose();
  }
}
