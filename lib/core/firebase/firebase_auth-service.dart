import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AthenticationService {

    // Google signin
  Future<void> signInwithGoogle(BuildContext context) async{
    //begin interactive signIn process
    final GoogleSignInAccount? gsignInAccount = await GoogleSignIn().signIn();
    //obtain oth details from request
    final GoogleSignInAuthentication gAuth = await gsignInAccount!.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally sign-in

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      var email = user?.email;
      var displayName = user?.displayName;
      var photoURL = user?.photoURL;


      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      //
      // print("Email id-->$email");
      // print("DisplayName --> $displayName");
      // print("PhotoURL -->$photoURL");

      // if(displayName != null){
      //   await prefs.setString('gname', displayName );
      //   await prefs.setString('gmail', email! );
      //   await prefs.setString('gphoto', photoURL! );
      //   await prefs.setBool('gsignin', true );
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const HomeProduct()),
      //   );
      //
      // }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print("account-exists-with-different-credential");
      }
      else if (e.code == 'invalid-credential') {
        // handle the error here
        print("invalid-credential");
      }
    } catch (e) {
      // handle the error here
      print("new_error");
    }
  }


}