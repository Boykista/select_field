import 'package:flutter/material.dart';
import 'package:select_field/src/option.dart';

class MenuDecoration<T> {
  /// Margin from `TextFormField`.
  final EdgeInsets? margin;

  /// Specifies overall `height` of options' menu. Default is `365.0`.
  final double? height;

  /// Specifies `width` of options' menu.
  ///
  /// It is constrained from `0` to `width` of `TextFormField`.
  final double? width;

  /// [BoxDecoration] for options' menu.
  final BoxDecoration? backgroundDecoration;

  /// Style of default `TextButton` if [optionBuilder] is not provided
  final ButtonStyle? buttonStyle;

  /// Style of deafult `Text` widget if [optionBuilder] is not provided
  final TextStyle? textStyle;

  /// Aligning `optionsMenu` (left, center, right)
  ///
  /// Will have an impact if [width] is provided
  final MenuAlignment? alignment;

  /// Time it takes to open or close the options' menu
  final Duration? animationDuration;

  /// Separates `options` by provided widget.
  /// Will be called with indices greater than or equal to zero and less than `options.length - 1`.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Specifies `child` widget of a default `TextButton` menu option widget.
  final Widget Function(
      BuildContext context, Option<T> option, bool isSelected)? childBuilder;

  MenuDecoration({
    this.margin,
    this.height,
    this.width,
    this.backgroundDecoration,
    this.buttonStyle,
    this.textStyle,
    this.alignment,
    this.animationDuration,
    this.separatorBuilder,
    this.childBuilder,
  });
}

enum MenuAlignment {
  left,
  center,
  right,
}

enum MenuPosition {
  above,
  below,
}
