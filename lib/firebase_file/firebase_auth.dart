import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:not/auth/msg_dialog.dart';

class FireBaseAuthControl {


  static Future<UserCredential?> createUser({required String emailAddress, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static   Future<UserCredential?> login({required String emailAddress, required String password,required BuildContext context}) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("user-not-found") ,));
        MsgDialog.alertMsg("user-not-found",context);
        print('$e No user found for that email.');
      } else if (e.code == 'wrong-password') {
        MsgDialog.alertMsg("wrong-password",context);

        print('$e Wrong password provided for that user.');
      }
    }
  }

  static Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if(googleUser==null){
          return false;
        }


      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);


    return true;
  }

  static Future<void> forgetPassword(String  email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
