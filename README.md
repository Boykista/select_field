# Select Field

Simple, easy and highly customizable input field for creating a dropdown list of selectable options.

## Key Features

With Select Field and Multi Select Field, you can:

- Customize the input field and dropdown menu to your preferences.
- Create custom widgets for the dropdown menu.
- Control menu's behaviour.
- Search through provided options.

## Limitations

- Custom animation of a dropdown menu is not supported.

## Example

<p><img src="https://github.com/Boykista/select_field/raw/main/doc/menu_below.gif" alt="An animated image of the select field (menu below)" height="400"/>
<img src="https://github.com/Boykista/select_field/raw/main/doc/menu_above.gif" alt="An animated image of the select field (menu above)" height="400"/>
<img src="https://github.com/Boykista/select_field/raw/main/doc/multi_select_custom.gif" alt="An animated image of the multi select field with custom menu control" height="400"/>
<img src="https://github.com/Boykista/select_field/raw/main/doc/multi_select_default.gif" alt="An animated image of the default multi select field" height="400"/>
<p>

```dart
const fruitOptions = <String>[
  'Apple',
  'Banana',
  'Strawberry',
  'Cherry',
  'Orange',
  'Raspberry',
];

class StyledSelectField extends StatelessWidget {
  const StyledSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    final options = fruitOptions
        .map((fruit) => Option(label: fruit, value: fruit))
        .toList();

    return SelectField<String>(
      options: options,
      initialOption: Option<String>(
        label: fruitOptions[0],
        value: fruitOptions[0],
      ),
      menuPosition: MenuPosition.below,
      onTextChanged: (value) => debugPrint(value),
      onOptionSelected: (option) => debugPrint(option.toString()),
      inputStyle: const TextStyle(),
      menuDecoration: MenuDecoration(
        margin: const EdgeInsets.only(top: 8),
        height: 365,
        alignment: MenuAlignment.center,
        backgroundDecoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              color: Colors.brown[300]!,
              blurRadius: 3,
            ),
          ],
        ),
        animationDuration: const Duration(milliseconds: 400),
        buttonStyle: TextButton.styleFrom(
          fixedSize: const Size(double.infinity, 60),
          backgroundColor: Colors.green[100],
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          width: double.infinity,
          color: Colors.green,
        ),
      ),
    );
  }
}
```

You can also call optionBuilder function to add your own widgets in dropdown menu:

```dart
SelectField<String>(
      options: options,
      optionBuilder: (context, option, isSelected, onOptionSelected) {
        return GestureDetector(
            // You have to call this function if menu's
            // default behaviour is needed (expanded or collapsed)
            onTap: () => onOptionSelected(option),
            child: isSelected
                ? Container(
                    height: 60,
                    color: Colors.deepOrange.withOpacity(0.2),
                    child: Center(
                      child: Text(
                        option.label,
                        style: const TextStyle(
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        option.label,
                        style: TextStyle(
                          color: Colors.orange[700],
                        ),
                      ),
                    ),
                  ),
        );
      },
    ),
```

An example of the MultiSelectField() with custom menu control:

```dart
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
            childBuilder: (context, option, isSelected) {
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
                    isSelected
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
```

More on <a href="https://github.com/Boykista/select_field/">https://github.com/Boykista/select_field/</a>.
