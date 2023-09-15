import 'package:example/data.dart';
import 'package:flutter/material.dart';
import 'package:select_field/select_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Field',
      theme: themeData,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final options = fruitOptions
        .map((fruit) => Option(label: fruit, value: fruit))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Field',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Custom style select field',
              style: TextStyle(
                color: Colors.brown[700],
              ),
            ),
            StyledSelectField(
              options: options,
            ),
            const SizedBox(height: 32),
            Text(
              'Custom menu select field',
              style: TextStyle(
                color: Colors.deepOrange[700],
              ),
            ),
            CustomMenuSelectField(options: options),
          ],
        ),
      ),
    );
  }
}

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
