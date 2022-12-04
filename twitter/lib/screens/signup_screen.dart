import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/all.dart';
import '../providers/all.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  final GlobalKey _formKey = GlobalKey(debugLabel: 'FormKey');

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthState>(
    builder: (context, state, child) => Scaffold(
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
                hint: 'Enter Username',
                controller: _usernameController,
              ),
              EntryField(
                hint: 'Enter Email',
                controller: _emailController,
              ),
              EntryField(
                hint: 'Enter Password',
                controller: _passwordController,
                isPassword: true,
              ),
              EntryField(
                hint: 'Confirm Password',
                controller: _confirmController,
                isPassword: true,
              ),
              FlatButton(
                label: 'Sign Up',
                onPressed: () => state.attemptSignUp(
                  context,
                  _nameController.text,
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  _confirmController.text,
                )
              ),
            ]
          ),
        ),
      ),
    ),
  );
}
