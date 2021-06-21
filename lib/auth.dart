import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthClass{

  FirebaseAuth auth = FirebaseAuth.instance;


  //create account
Future<String> createAccount({String email, String Password}) async{
  try {
    await auth.createUserWithEmailAndPassword(
        email: email,
        password: Password
    );
    return"Account created";
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return "Error occured";
  }
}



// signin user
  Future<String> SiginIn({String email, String Password}) async{
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: Password
      );
      return "Welcome";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }

  }



// reset password
  Future<String> ResetPassword({String email }) async{
    try {
      await auth.sendPasswordResetEmail(
          email: email,
      );
      return "Email sent";
    } catch(e){
      return "Error ocurred";
      }
    }


    //signout
  void signOut() {
  auth.signOut();
  }


  // Google Signin

Future<UserCredential> signwithGoogle() async{
  final GoogleSignInAccount googleUser = await GoogleSignIn(scopes: <String>["email"]).signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
}



// // signOut
// void signOut(){
//    FirebaseAuth.instance.signOut();
// }