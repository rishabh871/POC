import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jai_poc/features/login/presentation/bloc/login_event.dart';
import 'package:jai_poc/features/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc(super.initialState);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      final emailError = _validateEmailFormat(event.email);
      final passwordError = _validatePasswordFormat(event.password);

      if (emailError != null || passwordError != null) {
        yield LoginValidationError(
          emailError: emailError,
          passwordError: passwordError,
        );
        return;
      }

      yield LoginLoading();

      try {
        // Replace this with your actual login logic
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    } else if (event is GoogleLoginButtonPressed) {
      yield LoginLoading();

      try {
        await _signInWithGoogle();
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignInAccount? gsignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth =
    await gsignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print("account-exists-with-different-credential");
        throw e;
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print("invalid-credential");
        throw e;
      }
    } catch (e) {
      // handle the error here
      print("new_error");
      throw e;
    }
  }

  String? _validateEmailFormat(String value) {
    if (value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePasswordFormat(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }
}