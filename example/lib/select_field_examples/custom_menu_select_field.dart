import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

class CustomMenuSelectField<String> extends StatefulWidget {
  final List<Option<String>> options;

  const CustomMenuSelectField({
    super.key,
    required this.options,
  });

  @override
  State<CustomMenuSelectField<String>> createState() =>
      _CustomMenuSelectFieldState<String>();
}

class _CustomMenuSelectFieldState<String>
    extends State<CustomMenuSelectField<String>> {
  Option<String>? selectedOption;
  final SelectFieldMenuController<String> menuController =
      SelectFieldMenuController();

  @override
  void initState() {
    super.initState();
    menuController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SelectField<String>(
      menuController: menuController,
      options: widget.options,
      menuPosition: MenuPosition.below,
      optionBuilder: (context, option, onOptionSelected) {
        return GestureDetector(
          onTap: () {
            onOptionSelected(option);
            setState(() {
              selectedOption = option;
            });
          },
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
        );
      },
      menuDecoration: MenuDecoration(
        backgroundDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.red[300]!,
            ),
          ],
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          width: double.infinity,
          color: Colors.deepOrange,
        ),
      ),
      inputStyle: const TextStyle(color: Colors.deepOrange),
      inputDecoration: InputDecoration(
        hintText: 'Select fruit',
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.deepOrange,
        contentPadding: const EdgeInsets.all(16),
        errorStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.red[900],
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.orange[700],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepOrange[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.deepOrange,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red[900]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red[900]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
