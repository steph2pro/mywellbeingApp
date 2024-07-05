import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
//import 'package:mywellbeing/welcome_page.dart'; // Assurez-vous d'importer la page suivante

class Recaptcha extends StatefulWidget {
  const Recaptcha({super.key});
  @override
  _RecaptchaState createState() => _RecaptchaState();
}

class _RecaptchaState extends State<Recaptcha> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image.png', // Remplacez 'assets/image.png' par le chemin de votre image
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "I'm not a robot",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Code pour valider l'authentification
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
