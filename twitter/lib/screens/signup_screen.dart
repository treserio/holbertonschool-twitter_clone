import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/all.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  final GlobalKey _formKey = GlobalKey(debugLabel: 'FormKey');

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.grey.shade100,
      foregroundColor: Colors.black87,
      title: const Center(
        child: Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          )
        )
      ),
    ),
    body: Form(
      key: _formKey,
      child: Center(
        child: ListView(
          padding: const EdgeInsetsDirectional.only(
            start: 20,
            end: 20,
          ),
          shrinkWrap: true,
          children: [
            EntryField(
              hint: 'Enter Name',
              controller: _nameController,
            ),
            EntryField(
              hint: 'Enter email',
              controller: _emailController,
            ),
            EntryField(
              hint: 'Enter password',
              controller: _passwordController,
            ),
            EntryField(
              hint: 'Confirm password',
              controller: _confirmController,
            ),
            FlatButton(
              label: 'Sign Up',
              onPressed: () => print('Sign Up'),
            ),
          ]
        ),
      ),
    ),
  );
}
