import 'dart:core';
// import 'dart:html';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/all.dart';
import './all.dart';
import '../models/userData.dart';
import '../providers/all.dart';


class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<AuthState>(
    builder: (context, state, child) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black87,
        title: const Center(
          child: Text(
            'Sign in',
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
            EntryField(
              hint: 'Enter email',
              controller: _emailController,
            ),
            EntryField(
              hint: 'Enter password',
              isPassword: true,
              controller: _passwordController,
            ),
            FlatButton(
              onPressed: () => state.attemptLogin(
                context,
                _emailController,
                _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..color = Colors.blue.shade800,
                    ),
                  ),
                )
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPass()),
                  );
                },
                child: Center(
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      foreground: Paint()
                        ..color = Colors.blue.shade800,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    ),
  );
}
