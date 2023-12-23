import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';
import 'package:select_field/src/multi_select_field/multi_select_field_menu_controller.dart';

class MultiSelectField<T> extends StatefulWidget {
  /// List of options for the select field menu.
  final List<Option<T>> options;

  /// Initial option to display in input field
  final List<Option<T>>? initialOptions;

  /// Sets the text of the [TextFormField]
  final String? fieldText;

  /// Callback on `text change` in input field
  final void Function(String value)? onTextChanged;

  /// Callback for providing selected options list
  final void Function(List<Option<T>> options)? onOptionsSelected;

  /// Specifies the [TextEditingController] for [SelectField].
  final TextEditingController? textController;

  /// Controls if menu is expanded
  final bool isInitiallyExpanded;

  /// See [FocusNode]
  final FocusNode? focusNode;

  /// Callback when input field is tapped.
  final void Function()? onTap;

  /// Callback when tapped outside input field and options' menu.
  final void Function()? onTapOutside;

  /// Character that separates option labels inside [TextFormField]
  final String separatorChar;

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
  final Widget Function(
    BuildContext context,
    Option<T> option,
    bool isSelected,
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

  /// This
  final MultiSelectCustomControl<T>? customControl;

  const MultiSelectField({
    super.key,
    required this.options,
    this.initialOptions,
    this.fieldText,
    this.onTextChanged,
    this.onOptionsSelected,
    this.textController,
    this.isInitiallyExpanded = false,
    this.focusNode,
    this.onTap,
    this.onTapOutside,
    this.separatorChar = ';',
    this.hint,
    this.inputDecoration,
    this.inputStyle,
    this.menuPosition = MenuPosition.below,
    this.menuDecoration,
    this.textAlign = TextAlign.start,
    this.suffixIconBuilder,
    this.prefixIconBuilder,
    this.optionBuilder,
    this.restorationId,
    this.strutStyle,
    this.textDirection,
    this.textAlignVertical,
    this.maxLines = 1,
    this.enabled,
    this.onSaved,
    this.validator,
    this.customControl,
  });

  @override
  State<MultiSelectField<T>> createState() => _MultiSelectFieldState<T>();
}

class _MultiSelectFieldState<T> extends State<MultiSelectField<T>> {
  late final TextEditingController textController;
  late final MultiSelectFieldMenuController<T> menuController;
  List<Option<T>> selectedOptions = [];

  void addControllerText(String text) {
    final options = selectedOptions.map((option) => option.label);
    final text = options.join(widget.separatorChar);
    textController.text = text;
  }

// TODO: ADD SELECTED OPTIONS TO MENU CONTROLLER AND NOT AS STATE LIKE HERE
  void onOptionSelected(Option<T> option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
      menuController.selectedOptions = selectedOptions;
      if (widget.fieldText == null) {
        addControllerText(option.label);
      }
    } else {
      selectedOptions.add(option);
      menuController.selectedOptions = selectedOptions;
      if (widget.fieldText == null) {
        addControllerText(option.label);
      }
    }
    if (widget.onOptionsSelected != null) {
      widget.onOptionsSelected!(selectedOptions);
    }
    menuController.isExpanded = true;
  }

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.fieldText);

    menuController = MultiSelectFieldMenuController<T>(
      isExpanded: widget.isInitiallyExpanded,
      customControl: CustomControl(onOptionSelected: onOptionSelected),
    );

    if (widget.initialOptions != null) {
      selectedOptions = widget.initialOptions!;
    }
  }

  @override
  void didUpdateWidget(covariant MultiSelectField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.customControl?.selectedOptions !=
        oldWidget.customControl?.selectedOptions) {
      menuController.selectedOptions = widget.customControl!.selectedOptions;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectField<T>(
      options: widget.options,
      textController: textController,
      menuController: menuController,
      menuPosition: widget.menuPosition,
      hint: widget.hint,
      onTextChanged: widget.onTextChanged,
      onTapOutside: widget.onTapOutside,
      focusNode: widget.focusNode,
      onTap: widget.onTap,
      inputDecoration: widget.inputDecoration,
      restorationId: widget.restorationId,
      inputStyle: widget.inputStyle,
      textAlign: widget.textAlign,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlignVertical: widget.textAlignVertical,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      onSaved: widget.onSaved,
      validator: widget.validator,
      prefixIconBuilder: widget.prefixIconBuilder,
      suffixIconBuilder: widget.suffixIconBuilder,
      optionBuilder: widget.optionBuilder != null
          ? (context, option, onOptionSelected) => widget.optionBuilder!(
                context,
                option,
                selectedOptions.contains(option),
                onOptionSelected,
              )
          : null,
      menuDecoration: widget.menuDecoration ??
          MenuDecoration(
            childBuilder: (context, option, [isSelected]) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      option.label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context)
                            .textButtonTheme
                            .style
                            ?.foregroundColor
                            ?.resolve({}),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isSelected != null && isSelected)
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Theme.of(context)
                          .textButtonTheme
                          .style
                          ?.foregroundColor
                          ?.resolve({}),
                    )
                ],
              );
            },
          ),
    );
  }
}
