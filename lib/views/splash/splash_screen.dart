import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Get.offNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 233, 234),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/logogeoportail.png', width: 150, height: 150),
          ),
          const SizedBox(height: 40),
          // Loader
            const SpinKitCircle(
              color: Color(0xFF007533),
              size: 50.0,
            ),
          const SizedBox(height: 20),
          const Text(
            'Chargement...',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF007533), // Couleur du texte
            ),
          ),
        ],
      ),
    );
  }
}
