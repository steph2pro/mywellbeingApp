import 'package:flutter/material.dart';

class AlimentationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'L\'importance de l\'Alimentation',
            style: TextStyle(color: Colors.white), // Couleur blanche pour le titre de l'appbar
        ),
        backgroundColor: Colors.blue, // Couleur de fond de l'appbar
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'L\'Alimentation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour le titre principal
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'L\'alimentation désigne l\'acte de consommer des aliments pour '
              'fournir à l\'organisme les nutriments nécessaires à son bon '
              'fonctionnement. Une alimentation équilibrée est essentielle pour '
              'maintenir une bonne santé physique et mentale tout au long de la vie.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte principal
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienfaits d\'une Alimentation Équilibrée',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour les titres des sections
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Apport des nutriments essentiels comme les protéines, les glucides, les lipides, les vitamines et les minéraux',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte des éléments de liste
              ),
            ),
            Text(
              '- Soutien de la croissance et du développement',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Renforcement du système immunitaire',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Prévention des maladies chroniques comme l\'obésité, le diabète et les maladies cardiaques',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Amélioration de la concentration et des performances mentales',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Principes d\'une Alimentation Saine',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Pour maintenir une alimentation équilibrée, il est recommandé de :',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Consommer une variété d\'aliments pour assurer un apport complet en nutriments',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Limiter la consommation de sucres ajoutés, de gras saturés et de sel',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Boire suffisamment d\'eau pour maintenir une hydratation adéquate',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Privilégier les aliments frais et non transformés autant que possible',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
