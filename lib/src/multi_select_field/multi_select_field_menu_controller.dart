import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class MultiSelectFieldMenuController<T> extends SelectFieldMenuController<T> {
  late ValueNotifier<bool> _notifier;
  late ValueNotifier<List<Option<T>>> _selectedOptionsNotifier;

  MultiSelectFieldMenuController({bool isExpanded = false}) {
    _notifier = ValueNotifier(isExpanded);
    _selectedOptionsNotifier = ValueNotifier([]);
  }

  @override
  set isExpanded(bool value) {
    _notifier.value = value;
  }

  @override
  bool get isExpanded => _notifier.value;

  List<Option<T>> get selectedOptions => _selectedOptionsNotifier.value;

  set selectedOptions(List<Option<T>> options) {
    _selectedOptionsNotifier.value = [...options];
  }

  @override
  void addListener(void Function() onChanged) {
    _notifier.addListener(() {
      onChanged();
    });

    _selectedOptionsNotifier.addListener(() {
      onChanged();
    });
  }

  @override
  void dispose() {
    _notifier.dispose();
    _selectedOptionsNotifier.dispose();
  }
}
