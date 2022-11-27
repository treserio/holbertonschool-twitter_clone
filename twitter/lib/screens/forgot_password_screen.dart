import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/all.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({
    super.key,
  });

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  late TextEditingController _emailController;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black87,
      title: const Center(
        child: Text(
          'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          )
        )
      ),
    ),
    body: Center(
      child: ListView(
        padding: const EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
        ),
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Text(
                'Enter your email address below to receive password reset instruction',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  foreground: Paint()
                    ..color = Colors.grey.shade600,
                ),
              ),
            ),
          ),
          EntryField(
            hint: 'Enter email',
            controller: _emailController,
          ),
          FlatButton(
            onPressed: () => print('ForgotPass'),
          ),
        ]
      )
    ),
  );
}
