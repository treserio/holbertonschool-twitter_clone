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
        // primarySwatch: Colors.deepOrange,
        // primaryColor: Colors.purple,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade800),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            overlayColor: MaterialStateProperty.all<Color>(Colors.purple.shade800),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) =>
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
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
              hint: 'Enter email',
            ),
            EntryField(
              hint: 'Enter password',
              isPassword: true,
            ),
            const FlatButton(),
          ]
        )
      )
    );
  }
}
