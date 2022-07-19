import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepo() : _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      return user;
    });
  }

  // Check signIn
  bool isSignedIn() {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // sign up with email
  Future<User> signUpUserWithEmailPass(String email, String password) async {
    final UserCredential authResult =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult.user!;
  }

  // sign in with email and password
  Future<User> signInEmailAndPassword(String email, String password) async {
    final UserCredential authresult =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authresult.user!;
  }

  // sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // delete user
  Future<void> deleteUser() async {
    await _firebaseAuth.currentUser!.delete();
  }
}
