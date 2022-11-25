import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController controller = TextEditingController();


  EntryField({
    super.key,
    this.hint = 'default',
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.only(top: 15),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        filled: true,
        fillColor: Colors.grey.shade300,
        focusColor: Colors.blue,
        hintText: hint,
      ),
      obscureText: isPassword,
      // style: TextStyle(
      //   backgroundColor: Colors.grey.shade300,
      // ),
      textAlignVertical: const TextAlignVertical(y: 0),
    ),
  );
}
