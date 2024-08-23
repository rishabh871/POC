import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:jai_poc/features/home/presentation/ui/home_screen.dart';
import 'package:jai_poc/core/firebase/firebase_remote_config_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController =
      TextEditingController(text: "jai@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "123@12qwert");
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final remoteConfig = FirebaseRemoteConfigService();

  String? _emailError;
  String? _passwordError;

  void _validateEmail(String value) {
    _emailError = _validateEmailFormat(value);
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

  void _validatePassword(String value) {
    _passwordError = _validatePasswordFormat(value);
  }

  String? _validatePasswordFormat(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  void _handleSignIn(BuildContext context) {
    _analytics.logEvent(
      name: "login_screen",
      parameters: {
        "button_click": "Login",
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => ProductBloc(),
          child: const HomeScreen(),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? gsignInAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth =
        await gsignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      var email = user?.email;
      var displayName = user?.displayName;
      var photoURL = user?.photoURL;

      print("User Data email:$email displayName:$displayName");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        print("account-exists-with-different-credential");
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        print("invalid-credential");
      }
    } catch (e) {
      // handle the error here
      print("new_error");
    }
  }

  @override
  Widget build(BuildContext context) {
    checkVersion(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: _validateEmail,
                    ),
                    if (_emailError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _emailError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                      ),
                      obscureText: true,
                      onChanged: _validatePassword,
                    ),
                    if (_passwordError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _passwordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          _validateEmail(_usernameController.text);
                          _validatePassword(_passwordController.text);

                          if (_emailError == null && _passwordError == null) {
                            _handleSignIn(context);
                          }
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    // const SizedBox(height: 15),
                    // SizedBox(
                    //   width: 200,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       signInWithGoogle();
                    //     },
                    //     child: const Text('Google LogIn'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkVersion(BuildContext context) {
    try {
      var androidVersionCode =
          remoteConfig.getString(FirebaseRemoteConfigKeys.androidVersionCode);
      print("exception $androidVersionCode");
      if (androidVersionCode.isNotEmpty) {
        if (int.parse(androidVersionCode) > 1) {
          showUpgradeAlert(context);
        }
      }
    } catch (exception) {
      print("exception $exception");
    }
  }

  void showUpgradeAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('App Upgrade Available'),
          content: const Text(
              'A new version of the app is available. Please upgrade for the latest features and improvements.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Not Now'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Upgrade Now'),
            ),
          ],
        );
      },
    );
  }
}
