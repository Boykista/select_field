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
  late final MultiSelectFieldMenuController<String> menuController;

  void onOptionSelected(List<Option<String>> options) {
    setState(() {
      menuController.selectedOptions = options;
    });
  }

  void onOptionRemoved(Option<String> option) {
    final options = menuController.selectedOptions;
    options.remove(option);
    setState(() {
      menuController.selectedOptions = options;
    });
  }

  @override
  void initState() {
    super.initState();
    initalOptions = widget.options.sublist(1, 3);
    menuController = MultiSelectFieldMenuController(
      isExpanded: true,
      initalOptions: initalOptions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiSelectField<String>(
          options: widget.options,
          fieldText: 'Select fruit',
          onOptionsSelected: onOptionSelected,
          menuController: menuController,
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
                    menuController.selectedOptions.contains(option)
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
          children: menuController.selectedOptions
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
