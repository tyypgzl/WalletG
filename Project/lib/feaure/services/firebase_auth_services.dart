import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print("Error:${e.message}");
      return false;
    }
  }

  Future<bool> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print("Error:${e.message}");
      return false;
    }
  }

  Future<bool> signOut() async {
    bool control = false;
    try {
      await _firebaseAuth.signOut();
      control = true;
    } on FirebaseAuthException catch (e) {
      print("Error:${e.message}");
      control = false;
    }
    return control;
  }
}
