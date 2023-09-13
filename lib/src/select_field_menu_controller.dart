import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class SelectFieldMenuController<T> {
  late ValueNotifier<bool> _notifier;
  final CustomControl<T>? customControl;

  SelectFieldMenuController({
    bool isExpanded = false,
    this.customControl,
  }) {
    _notifier = ValueNotifier(isExpanded);
  }

  set isExpanded(bool value) {
    _notifier.value = value;
  }

  bool get isExpanded => _notifier.value;

  void addListener(void Function() onChanged) {
    _notifier.addListener(() {
      onChanged();
    });
  }

  void dispose() {
    _notifier.dispose();
  }
}

class CustomControl<T> {
  /// ```dart
  /// // DEFAULT
  /// if (widget.onTap != null) {
  ///    widget.onTap!();
  ///  }
  /// final isExpanded = menuController.isExpanded;
  /// menuController.isExpanded = !menuController.isExpanded;
  ///
  /// if (isExpanded) {
  ///   await Future.delayed(widget.optionsDecoration?.animationDuration ??
  ///       const Duration(milliseconds: 350));
  ///
  ///   focusNode.unfocus();
  /// }
  ///   ```
  final void Function()? onTap;

  /// ```dart
  /// // DEFAULT
  /// if (widget.onTapOutside != null) {
  ///  widget.onTapOutside!();
  /// }
  /// if (menuController.isExpanded) {
  ///  menuController.isExpanded = false;
  ///  await Future.delayed(
  ///    widget.optionsDecoration?.animationDuration ??
  ///         const Duration(milliseconds: 350),
  ///   );
  /// }
  /// if (focusNode.hasFocus) {
  ///   focusNode.unfocus();
  /// }
  /// ```
  final void Function()? onTapOutside;

  /// ```dart
  /// // DEFAULT
  /// if (widget.onOptionSelected != null) {
  ///  widget.onOptionSelected!(option);
  /// }
  /// setControllerText(option.label);
  /// menuController.isExpanded = false;
  ///
  /// await Future.delayed(
  ///  widget.optionsDecoration?.animationDuration ??
  ///      const Duration(milliseconds: 350),
  /// );
  ///
  /// focusNode.unfocus();
  /// ```
  final void Function(Option<T> option)? onOptionSelected;

  CustomControl({
    this.onTap,
    this.onTapOutside,
    this.onOptionSelected,
  });
}
