import 'dart:async';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signUpWithDisplayName(
      String email, String password, String displayName);
  Future<User> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
  Future<void> resetPassword(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return user.uid;
  }

  Future<void> signUpWithDisplayName(
      String email, String password, String displayName) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (result) {
        result = result;
        UserInfo userUpdateInfo = new UserInfo();
        UserInfo.displayName = displayName;
        return result.user.updateProfile(UserInfo);
      },
    );
  }

  Future<User> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = await _firebaseAuth.currentUser;
    return user.isEmailVerified();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
