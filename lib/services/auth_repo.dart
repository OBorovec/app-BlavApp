import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepo() : _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.userChanges().map((user) {
      return user;
    });
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

  // check signIn
  Future<bool> isSignedIn() async {
    final User? currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  // get current user
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }
}
