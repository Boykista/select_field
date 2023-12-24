import 'package:flutter/material.dart';

class SelectFieldMenuController<T> {
  late ValueNotifier<bool> _isExpandedNotifier;

  SelectFieldMenuController({
    bool isExpanded = false,
  }) {
    _isExpandedNotifier = ValueNotifier(isExpanded);
  }

  set isExpanded(bool value) {
    _isExpandedNotifier.value = value;
  }

  bool get isExpanded => _isExpandedNotifier.value;

  void addListener(void Function() onChanged) {
    _isExpandedNotifier.addListener(() {
      onChanged();
    });
  }

  void dispose() {
    _isExpandedNotifier.dispose();
  }
}
