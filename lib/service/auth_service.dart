import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:virtual_store/screens/login_screen.dart';
import 'package:virtual_store/service/tab_service.dart';

import '../screens/home_screen.dart';
import '../screens/reset_pass_screen.dart';
import '../screens/signup_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  handleAuthState() {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        }
        return LoginScreen();
      },
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  signInWithEmail(
      {required context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  Future createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final docUser = _db.collection('users').doc();

    final user =
        User(id: docUser.id, name: name, email: email, password: password);

    final userData = user.toMap();

    await docUser.set(userData);
    _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  sendResetPassEmail({required email}) {
    _auth.sendPasswordResetEmail(email: email);
  }

}

class User {
  late String id;
  late final String name;
  late final String email;
  late final String password;

  User({
    this.id = '',
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}


