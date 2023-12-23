import 'package:example/data.dart';
import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class StyledSelectField extends StatelessWidget {
  final List<Option<String>> options;

  const StyledSelectField({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
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
        width: null,
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
