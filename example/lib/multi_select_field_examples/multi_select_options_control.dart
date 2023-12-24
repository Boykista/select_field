import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class MultiSelectOptionsControl<String> extends StatefulWidget {
  final List<Option<String>> options;

  const MultiSelectOptionsControl({
    super.key,
    required this.options,
  });

  @override
  State<MultiSelectOptionsControl<String>> createState() =>
      _MultiSelectOptionsControlState<String>();
}

class _MultiSelectOptionsControlState<String>
    extends State<MultiSelectOptionsControl<String>> {
  late final List<Option<String>> initalOptions;
  late final MultiSelectFieldMenuController<String> customControl;

  void onOptionSelected(List<Option<String>> options) {
    setState(() {
      customControl.selectedOptions = options;
    });
  }

  void onOptionRemoved(Option<String> option) {
    final options = customControl.selectedOptions;
    options.remove(option);
    setState(() {
      customControl.selectedOptions = options;
    });
  }

  @override
  void initState() {
    super.initState();
    initalOptions = widget.options.sublist(1, 3);
    customControl = MultiSelectFieldMenuController(isExpanded: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiSelectField<String>(
          options: widget.options,
          initialOptions: initalOptions,
          fieldText: 'Select fruit',
          onOptionsSelected: onOptionSelected,
          menuController: customControl,
          menuDecoration: MenuDecoration(
            childBuilder: (context, option) {
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
                  Icon(
                    customControl.selectedOptions.contains(option)
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank_outlined,
                    color: Theme.of(context)
                        .textButtonTheme
                        .style
                        ?.foregroundColor
                        ?.resolve({}),
                  ),
                ],
              );
            },
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 20,
          children: customControl.selectedOptions
              .map(
                (option) => Chip(
                  label: Text(option.label),
                  onDeleted: () => onOptionRemoved(option),
                  shape: const StadiumBorder(),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
