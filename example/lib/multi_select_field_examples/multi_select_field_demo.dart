import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class MultiSelectFieldDemo<String> extends StatefulWidget {
  final List<Option<String>> options;

  const MultiSelectFieldDemo({
    super.key,
    required this.options,
  });

  @override
  State<MultiSelectFieldDemo<String>> createState() =>
      _MultiSelectFieldDemoState<String>();
}

class _MultiSelectFieldDemoState<String>
    extends State<MultiSelectFieldDemo<String>> {
  late final List<Option<String>> initalOptions;

  @override
  void initState() {
    super.initState();
    initalOptions = widget.options.sublist(1, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MultiSelectField<String>(
          options: widget.options,
          initialOptions: initalOptions,
          hint: 'Select fruit',
          optionBuilder: (context, option, isSelected, onOptionSelected) {
            return GestureDetector(
              onTap: () {},
              child: isSelected
                  ? Container(
                      height: 60,
                      color: Colors.purple.withOpacity(0.2),
                      child: Center(
                        child: Text(
                          option.label,
                          style: const TextStyle(
                            color: Colors.purple,
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
                            color: Colors.purple[700],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}
