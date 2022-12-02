import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userData.dart';


enum Error {
  none,
  matchError,
  weakError,
  emailAlreadyInUse,
  error,
  wrongError,
  noUserError
}
class AuthState extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  final userDataRef = FirebaseFirestore
    .instance
    .collection('userData')
    .withConverter<UserData>(
      fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
      toFirestore: (userData, _) => userData.toJson(),
    );

  attemptSignUp(
    BuildContext context,
    String name,
    String userName,
    String email,
    String password,
    String confirm,
  ) async {
    String snackText = 'Account Created!';
    if (name == '') {
      snackText = 'Please enter your Name';
    } else if (userName == '') {
      snackText = 'Please enter your Username';
    } else if (email == '') {
      snackText = 'Please enter you Email';
    } else if (password == '') {
      snackText = 'Please enter a Password';
    } else if (password != confirm) {
      snackText = "Passwords entered don't match.";
    } else {
      try {
        final credential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        // userDataRef.doc(credential.user!.uid).set(
        //   UserData(
        //     name: name,
        //     userName: userName,
        //     email: credential.user!.email!,
        //   )
        // );
        userDataRef.add(
          UserData(
            key: credential.user!.uid,
            name: name,
            userName: userName,
            email: credential.user!.email!,
          )
        );
      } on FirebaseAuthException catch (e) {
        switch(e.code) {
          case 'email-already-in-use': {
            snackText = 'An account already exists with that email.';
          } break;

          case 'invalid-email': {
            snackText = 'Please enter a valid email address.';
          } break;

          case 'weak-password': {
            snackText = 'The password provided is too weak.';
          } break;
        }
      } catch (e) {
        snackText = 'Failed to create account! Please try later.';
      }
    }
    // build the snackbar here
    final snackBar = SnackBar(
      content: Text(snackText),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // listener won't listen
  // var listener = FirebaseAuth.instance
  //   .authStateChanges()
  //   .listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });

  int _test = 0;
  int get test => _test;
  set test(int val) {
    _test = val;
    notifyListeners();
  }
}
