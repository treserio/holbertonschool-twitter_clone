import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  final String label;

  const FlatButton({
    super.key,
    this.label = 'Submit',
  });

  void onPressed() => 'testing';

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    ),
    child: Text(label),
  );
}
