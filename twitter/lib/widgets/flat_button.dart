import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlatButton extends StatelessWidget {
  final String label;

  const FlatButton({
    super.key,
    this.label = 'Submit',
  });

  void onPressed() => 'testing';

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 15),
    child: TextButton(
    onPressed: onPressed,
    child: Text(
      label,
      style: GoogleFonts.mulish(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    ),
  );
}
