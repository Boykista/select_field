# Select Field

Simple, easy and highly customizable input field for creating a dropdown list of selectable options.

## Key Features

With Select Field, you can:

- Customize the input field and dropdown menu to your preferences.
- Add custom control for the dropdown menu.
- Create custom widgets for the dropdown menu.

## Limitations

Select Field has its limitations:

- You cannot select multiple options simultaneously.
- Custom animation of dropdown menu is not supported.

## Example

<p><img src="https://github.com/Boykista/select_field/blob/main/doc/menu_below.gif" alt="An animated image of the select field (menu below)" height="400"/>
<img src="https://github.com/Boykista/select_field/blob/main/doc/menu_above.gif" alt="An animated image of the select field (menu above)" height="400"/>
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
      optionBuilder: (context, option, onOptionSelected) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            // You have to call this function if menu's
            // default behaviour is needed (expanded or collapsed)
            onTap: () => onOptionSelected(option),
            child: selectedOption == option
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
          ),
        );
      },
    ),
```

More in this <a href="https://github.com/Boykista/select_field/blob/main/example/lib/main.dart" >example</a>
