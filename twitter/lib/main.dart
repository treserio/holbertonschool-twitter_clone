import 'package:flutter/material.dart';
import './widgets/entry_field.dart';
import './widgets/flat_button.dart';
import './screens/signin_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
            minimumSize: MaterialStateProperty.all<Size>(const Size(0, 60)),
          ),
        ),
        textTheme: GoogleFonts.mulishTextTheme()
      ),
      home: const SignIn(),
    );
  }
}
