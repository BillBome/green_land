import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_land/models/user_model.dart';

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(UserModel user) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return _auth.currentUser;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
}

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(UserModel user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      return _auth.currentUser;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }
}

class SignOutService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class GetUserByEmail {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getUserByEmail(String email) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: 'dummyPassword',
      );
      return userCredential.user;
    } catch (e) {
      print('Error getting user by email: $e');
      return null;
    }
  }
}
