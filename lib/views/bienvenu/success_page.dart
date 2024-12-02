import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geoportail/views/auth/login_page.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Démarrer le chargement après 2 secondes (ou une autre durée selon ton besoin)
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), 
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Succès',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF007533),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Données soumises avec succès !',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF33691B),
              ),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 40),

            // // Afficher le GIF juste en dessous des textes
            // Image.asset(
            //   'assets/images/zero-waste.gif', 
            //   width: 100,
            //   height: 100,
            // ),
            const SizedBox(height: 20), 
            
            Image.asset(
              'assets/images/imagesucces.png', 
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 40),

            // Loader
            const SpinKitCircle(
              color: Color(0xFF007533),
              size: 50.0,
            ),
            const SizedBox(height: 20),

            // const Text(
            //   'Chargement en cours...',
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Color(0xFF33691B),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
