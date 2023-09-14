import 'package:flutter/material.dart';
import 'package:select_field/src/option.dart';
import 'package:select_field/src/menu_decoration.dart';
import 'package:select_field/src/options_menu.dart';
import 'package:select_field/src/select_field_menu_controller.dart';

typedef IconBuilder = Widget Function(BuildContext context, bool isExpanded);

/// `Input field` for creating a `dropdown list` of `options`
/// that users can select from.
class SelectField<T> extends StatefulWidget {
  /// List of options for the select field menu.
  final List<Option<T>> options;

  /// Initial option to display in input field
  final Option<T>? initialOption;

  /// Callback on `text change` in input field
  final void Function(String value)? onTextChanged;

  /// Callback when user `selects` the `option`
  final void Function(Option<T> option)? onOptionSelected;

  /// Specifies the [TextEditingController] for [SelectField].
  final TextEditingController? textController;

  /// Allows you to control menu's behavior or add a custom control.
  ///
  /// With `customControl` you are responsible for `focus`, `text` and `menu` behaviour.
  final SelectFieldMenuController<T>? menuController;

  /// See [FocusNode]
  final FocusNode? focusNode;

  /// Callback when input field is tapped.
  final void Function()? onTap;

  /// Callback when tapped outside input field and options' menu.
  final void Function()? onTapOutside;

  /// `Text` that suggests what sort of input the field accepts.
  ///
  /// See [InputDecoration.hintText].
  final String? hint;

  /// The `border`, `labels`, `icons`, and `styles` used to decorate `input field`.
  ///
  /// See [InputDecoration].
  final InputDecoration? inputDecoration;

  /// Style describing how to format and paint `text` of `input field`.
  final TextStyle? inputStyle;

  /// Positions menu `below` or `above` input field.
  final MenuPosition menuPosition;

  /// Allows `customization` of `dropdown menu`.
  final MenuDecoration<T>? menuDecoration;

  /// Whether and how to align text horizontally in input field
  final TextAlign textAlign;

  /// An icon that appears after the editable part of the text field and after the
  /// [InputDecoration.suffix] or [InputDecoration.suffixText].
  final IconBuilder? suffixIconBuilder;

  /// An icon that appears before the [InputDecoration.prefix] or [InputDecoration.prefixText]
  /// and before the editable part of the input field.
  final IconBuilder? prefixIconBuilder;

  /// Callback for creating `custom option widget`.
  ///
  /// If `deafult behaviour` of options' menu is needed, call `onOptionSelected(option)`
  /// when user selects (taps, presses) the option.
  ///
  /// ```dart
  ///    SelectField<String>(
  ///      menuController: menuController,
  ///      options: widget.options,
  ///      optionBuilder: (context, option, onOptionSelected) {
  ///        return Material(
  ///          color: Colors.transparent,
  ///          child: GestureDetector(
  ///              onTap: () {
  ///                onOptionSelected(option);
  ///              },
  ///              child: Container(
  ///                height: 60,
  ///                color: Colors.deepOrange.withOpacity(0.2),
  ///                child: Center(
  ///                  child: Text(
  ///                    option.label,
  ///                    style: const TextStyle(
  ///                      color: Colors.deepOrange,
  ///                    ),
  ///                  ),
  ///                ),
  ///              ),
  ///           ),
  ///        );
  ///      },
  ///   ),
  /// ```
  final Widget Function(
    BuildContext context,
    Option<T> option,
    void Function(Option<T> option) onOptionSelected,
  )? optionBuilder;

  /// Restoration ID to save and restore the state of the form field.
  final String? restorationId;

  /// Defines the strut, which sets the minimum height a line can be relative to the baseline.
  /// See [TextFormField] for more.
  final StrutStyle? strutStyle;

  /// A direction in which text flows.
  final TextDirection? textDirection;

  /// The vertical alignment of text within an input box.
  final TextAlignVertical? textAlignVertical;

  /// Maximum lines of text in input field. Defaults to `1`.
  final int maxLines;

  /// Whether the input field is able to receive user input. Defaults to `true`.
  final bool? enabled;

  /// Method to call with the final value when the form is saved via [FormState.save].
  final void Function(String? value)? onSaved;

  /// Method that validates an input.
  /// Returns an error string to display if the input is invalid, or null otherwise.
  final String? Function(String? value)? validator;

  const SelectField({
    Key? key,
    required this.options,
    this.initialOption,
    this.onTextChanged,
    this.onOptionSelected,
    this.textController,
    this.menuController,
    this.focusNode,
    this.onTap,
    this.onTapOutside,
    this.hint,
    this.inputDecoration,
    this.inputStyle,
    this.menuPosition = MenuPosition.below,
    this.menuDecoration,
    this.textAlign = TextAlign.start,
    this.prefixIconBuilder,
    this.suffixIconBuilder,
    this.optionBuilder,
    this.restorationId,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.maxLines = 1,
    this.enabled,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  State<SelectField<T>> createState() => _SelectFieldState<T>();
}

class _SelectFieldState<T> extends State<SelectField<T>> {
  OverlayEntry? _overlayEntry;
  late final TextEditingController textController;
  late final FocusNode focusNode;
  LayerLink layerLink = LayerLink();
  late final SelectFieldMenuController<T> menuController;

  void initOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: widget.menuDecoration?.width?.clamp(0, size.width) ?? size.width,
        child: OptionsMenu<T>(
          link: layerLink,
          options: widget.options,
          initialOption: widget.initialOption,
          textController: textController,
          position: widget.menuPosition,
          onOptionSelected: onOptionSelected,
          decoration: widget.menuDecoration,
          menuController: menuController,
          builder: widget.optionBuilder,
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);
  }

  void setControllerText(String text) {
    textController.text = text;
    textController.selection =
        TextSelection.collapsed(offset: textController.text.length);

    if (widget.onTextChanged != null) {
      widget.onTextChanged!(text);
    }
  }

  void onOptionSelected(Option<T> option) async {
    if (menuController.customControl?.onOptionSelected != null) {
      menuController.customControl!.onOptionSelected!(option);
    } else {
      if (widget.onOptionSelected != null) {
        widget.onOptionSelected!(option);
      }
      setControllerText(option.label);
      menuController.isExpanded = false;

      await Future.delayed(
        widget.menuDecoration?.animationDuration ??
            const Duration(milliseconds: 350),
      );

      focusNode.unfocus();
    }
  }

  void handleOnTapOutside() async {
    if (menuController.customControl?.onTapOutside != null) {
      menuController.customControl!.onTapOutside!();
    } else {
      if (widget.onTapOutside != null) {
        widget.onTapOutside!();
      }
      if (menuController.isExpanded) {
        menuController.isExpanded = false;
        await Future.delayed(
          widget.menuDecoration?.animationDuration ??
              const Duration(milliseconds: 350),
        );
      }
      if (focusNode.hasFocus) {
        focusNode.unfocus();
      }
    }
  }

  void handleOnTap() async {
    if (menuController.customControl?.onTap != null) {
      menuController.customControl!.onTap!();
    } else {
      if (widget.onTap != null) {
        widget.onTap!();
      }
      final isExpanded = menuController.isExpanded;
      menuController.isExpanded = !menuController.isExpanded;

      if (isExpanded) {
        await Future.delayed(widget.menuDecoration?.animationDuration ??
            const Duration(milliseconds: 350));

        focusNode.unfocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    textController = widget.textController ?? TextEditingController();
    menuController = widget.menuController ?? SelectFieldMenuController();

    if (widget.initialOption != null) {
      setControllerText(widget.initialOption!.label);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initOverlay();
    });

    menuController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.textController == null) {
      textController.dispose();
    }
    if (widget.menuController == null) {
      menuController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TapRegion(
        groupId: SelectFieldTapRegion.fieldAndOverlay,
        onTapOutside: (event) => handleOnTapOutside(),
        child: TextFormField(
          controller: textController,
          readOnly: true,
          focusNode: focusNode,
          onChanged: widget.onTextChanged,
          onTap: handleOnTap,
          decoration: widget.inputDecoration ??
              InputDecoration(
                hintText: widget.hint,
                prefixIcon: widget.prefixIconBuilder != null
                    ? widget.prefixIconBuilder!(
                        context, menuController.isExpanded)
                    : null,
                suffixIcon: widget.suffixIconBuilder != null
                    ? widget.suffixIconBuilder!(
                        context, menuController.isExpanded)
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedRotation(
                          duration: widget.menuDecoration?.animationDuration ??
                              const Duration(milliseconds: 350),
                          turns: menuController.isExpanded ? -0.5 : 0,
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: menuController.isExpanded
                                ? Theme.of(context)
                                    .inputDecorationTheme
                                    .focusColor
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
              ),
          restorationId: widget.restorationId,
          style: widget.inputStyle ??
              TextStyle(
                color: menuController.isExpanded
                    ? Theme.of(context).inputDecorationTheme.focusColor
                    : Theme.of(context).colorScheme.onSurface,
              ),
          textAlign: widget.textAlign,
          strutStyle: widget.strutStyle,
          textDirection: widget.textDirection,
          textAlignVertical: widget.textAlignVertical,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          onSaved: widget.onSaved,
          validator: widget.validator,
        ),
      ),
    );
  }
}
