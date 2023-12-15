import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class MultiSelectFieldMenuController<T> extends SelectFieldMenuController<T> {
  late ValueNotifier<bool> _notifier;
  late ValueNotifier<List<Option<T>>> _selectedOptionsNotifier;

  MultiSelectFieldMenuController({
    bool isExpanded = false,
    super.customControl,
  }) {
    _notifier = ValueNotifier(isExpanded);
    _selectedOptionsNotifier = ValueNotifier([]);
  }

  set addSelectedOption(Option<T> option) {
    final newValue = _selectedOptionsNotifier.value.toList();
    newValue.add(option);
    _selectedOptionsNotifier.value = newValue;
  }

  set removeSelectedOption(Option<T> option) {
    _selectedOptionsNotifier.value;
    final newValue = _selectedOptionsNotifier.value.toList();
    newValue.remove(option);
    _selectedOptionsNotifier.value = newValue;
  }

  @override
  set isExpanded(bool value) {
    _notifier.value = value;
  }

  @override
  bool get isExpanded => _notifier.value;

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

// class CustomControl<T> {
//   /// ```dart
//   /// // DEFAULT
//   /// if (widget.onTap != null) {
//   ///    widget.onTap!();
//   ///  }
//   /// final isExpanded = menuController.isExpanded;
//   /// menuController.isExpanded = !menuController.isExpanded;
//   ///
//   /// if (isExpanded) {
//   ///   await Future.delayed(widget.optionsDecoration?.animationDuration ??
//   ///       const Duration(milliseconds: 350));
//   ///
//   ///   focusNode.unfocus();
//   /// }
//   ///   ```
//   final void Function()? onTap;

//   /// ```dart
//   /// // DEFAULT
//   /// if (widget.onTapOutside != null) {
//   ///  widget.onTapOutside!();
//   /// }
//   /// if (menuController.isExpanded) {
//   ///  menuController.isExpanded = false;
//   ///  await Future.delayed(
//   ///    widget.optionsDecoration?.animationDuration ??
//   ///         const Duration(milliseconds: 350),
//   ///   );
//   /// }
//   /// if (focusNode.hasFocus) {
//   ///   focusNode.unfocus();
//   /// }
//   /// ```
//   final void Function()? onTapOutside;

//   /// ```dart
//   /// // DEFAULT
//   /// if (widget.onOptionSelected != null) {
//   ///  widget.onOptionSelected!(option);
//   /// }
//   /// setControllerText(option.label);
//   /// menuController.isExpanded = false;
//   ///
//   /// await Future.delayed(
//   ///  widget.optionsDecoration?.animationDuration ??
//   ///      const Duration(milliseconds: 350),
//   /// );
//   ///
//   /// focusNode.unfocus();
//   /// ```
//   final void Function(Option<T> option)? onOptionSelected;

//   CustomControl({
//     this.onTap,
//     this.onTapOutside,
//     this.onOptionSelected,
//   });
// }
