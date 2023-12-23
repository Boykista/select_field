import 'package:example/data.dart';
import 'package:example/multi_select_field_examples/multi_select_field_demo.dart';
import 'package:example/multi_select_field_examples/multi_select_options_control.dart';
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
          'Multi Select Field',
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
            // Text(
            //   'Custom style select field',
            //   style: TextStyle(
            //     color: Colors.brown[700],
            //   ),
            // ),
            // StyledSelectField(
            //   options: options,
            // ),
            // const SizedBox(height: 32),
            // Text(
            //   'Custom menu select field',
            //   style: TextStyle(
            //     color: Colors.deepOrange[700],
            //   ),
            // ),
            // CustomMenuSelectField(options: options),
            // const SizedBox(height: 32),
            // MultiSelectOptionsControl<String>(options: options),
            MultiSelectFieldDemo<String>(options: options)
          ],
        ),
      ),
    );
  }
}
