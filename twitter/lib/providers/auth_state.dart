import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userData.dart';
import '../screens/all.dart';


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
  FirebaseAuth authState = FirebaseAuth.instance;
  late UserData? activeUserData;

  final userDataRef = FirebaseFirestore
    .instance
    .collection('userData')
    .withConverter<UserData>(
      fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
      toFirestore: (userData, _) => userData.toJson(),
    );

  // AuthState({
  //   this.activeUserData = const userDataRef.doc(auth.currentUser!.uid),
  // });

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
    }
    else if (userName == '') {
      snackText = 'Please enter your Username';
    }
    else if (email == '') {
      snackText = 'Please enter you Email';
    }
    else if (password == '') {
      snackText = 'Please enter a Password';
    }
    else if (password != confirm) {
      snackText = "Passwords entered don't match.";
    }
    else {
      try {
        final credential = await authState
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        userDataRef.doc(credential.user!.uid).set(
          UserData(
            key: credential.user!.uid,
            name: name,
            userName: userName,
            displayName: userName,
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
      backgroundColor: snackText == 'Account Created!' ?
        Colors.green : Colors.red,
      content: Text(snackText),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  attemptLogin(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController
  ) async {
    String snackText = '';
    if (emailController.text == '') {
      snackText = 'Please enter your Email';
    } else if (passwordController.text == '') {
      snackText = 'Please enter your Password';
    } else {
      try {
        final credential = await authState.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        var userSnap = await userDataRef.doc(credential.user!.uid).get();
        activeUserData = userSnap.data();
      } on FirebaseAuthException catch (e) {
        switch(e.code) {
          case 'invalid-email': {
            snackText = 'Please enter a valid email address.';
          } break;

          case 'user-disabled': {
            snackText = 'This user has been disabled, please try again later.';
          } break;

          case 'user-not-found': {
            snackText = 'No user found for that email.';
          } break;

          case 'wrong-password': {
            snackText = 'Incorrect Password';
          } break;
        }
      } catch (e) {
        snackText = 'Failed to Login! Please try again.';
      }
    }
    final snackBar = SnackBar(
      backgroundColor: snackText == '' ?
        Colors.green : Colors.red,
      content: Text(snackText == '' ?
        'Welcome ${activeUserData?.userName}' : snackText
      ),
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if (snackText == '') {
      emailController.text = '';
      passwordController.text = '';
    }
    notifyListeners();
  }

  logout(BuildContext context, appState) {
    appState.setpageIndex = 0;
    authState.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  // listener won't listen
  var listener = FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

  int _test = 0;
  int get test => _test;
  set test(int val) {
    _test = val;
    notifyListeners();
  }
}
