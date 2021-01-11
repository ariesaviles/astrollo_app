import 'package:firebase_auth/firebase_auth.dart';

// tutorial by The Net Ninja
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in for guests
  Future signInGuest() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email

  // join with email

  // sign out
}