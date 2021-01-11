import 'package:astrollo_app/global_comps/user_object.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// tutorial by The Net Ninja
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj
  User _userFromFirebase(FirebaseUser user) {
    // if user is not null return new User instance from Firebase uid
    return user != null ? User(uid: user.uid) : null;
    // : else return null
  }

  // set up stream, auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebase(user));
    // could be written as:
    //  .map(_userFromFirebase(user));
  }

  // sign in for guests
  Future signInGuest() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
      // this returns a User Object
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email

  // join with email

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // delete account


}