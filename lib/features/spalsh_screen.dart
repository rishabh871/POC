import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jai_poc/features/home/presentation/bloc/product_bloc.dart';
import 'package:jai_poc/features/login/presentation/ui/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

// Bloc,Getx,mobx,provider

    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => ProductBloc(),
                  child: LoginPage(),
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            // throw Exception("Custom Testing Crash"),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/splash_back.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Center(
            //   child: Container(
            //     width: 150,
            //     height: 150,
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.white,
            //     ),
            //     child: Image.network(
            //       'https://tinypng.com/images/social/website.jpg',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
