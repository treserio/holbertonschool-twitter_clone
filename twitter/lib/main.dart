import 'package:flutter/material.dart';
import './widgets/entry_field.dart';
import './widgets/flat_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squacker',
      theme: ThemeData(
        // primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          foregroundColor: Colors.black87,
          title: const Center(
            child: Text(
              'Squacker',
              textAlign: TextAlign.center,
            )
          ),
        ),
        body: ListView(
          children: [
            EntryField(
              hint: 'Enter Email',
            ),
            EntryField(
              hint: 'Enter Password',
              isPassword: true,
            ),
            const FlatButton(),
          ]
        )
      )
    );
  }
}
