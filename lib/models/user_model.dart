import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  Map<String, dynamic> userData = {};
  UserCredential? userCredential;

  void signUp({
    required String userName,
    required String userEmail,
    required String pass,
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
          email: userEmail,
          password: pass,

        ).then((user) async {

          await _saveUserData(userName, userEmail);

          onSuccess();
          isLoading = false;
          notifyListeners();

    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signInWithEmail (
      {required String email,
        required String password,
        required VoidCallback onSuccess,
        required VoidCallback onFail}
      ) async {

    isLoading = true;
    notifyListeners();

    await _auth.signInWithEmailAndPassword(email: email, password: password).then((u) async {
      user = u.user;
      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
    }

  signInWithGoogle({required VoidCallback onSuccess,
    required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: ['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential).then((u) async {
      user = u.user;
      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }

  bool isLoggedIn() {
    return user != null;
  }

  Future _saveUserData(userName, userEmail) async {
    String userId = _db.collection('users').doc().id;

    Map<String, dynamic> userData = {
      'id': userId,
      'name': userName,
      'email': userEmail,
    };

    await _db.collection('users').doc().set(userData);
  }

  sendResetPassEmail({required email, required VoidCallback onSuccess,
    required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();

    _auth.sendPasswordResetEmail(email: email).then((u) async {

      onSuccess();
      isLoading = false;
      notifyListeners();

    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }


}



