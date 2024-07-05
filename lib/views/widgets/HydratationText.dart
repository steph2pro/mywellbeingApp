import 'package:flutter/material.dart';

class HydratationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'L\'Importance de l\'Hydratation',
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
              'L\'Hydratation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour le titre principal
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'L\'hydratation fait référence à la consommation d\'eau nécessaire '
              'pour maintenir un bon équilibre hydrique dans le corps. C\'est un '
              'aspect essentiel de la santé globale, influençant de nombreux '
              'aspects du bien-être physique et mental.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte principal
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienfaits de l\'Hydratation',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour les titres des sections
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Régulation de la température corporelle',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte des éléments de liste
              ),
            ),
            Text(
              '- Transport des nutriments essentiels dans tout le corps',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Lubrification des articulations et des tissus',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Élimination des toxines et des déchets métaboliques',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Maintien de la fonction cognitive et de la concentration',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Quantité Recommandée',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Les besoins en hydratation varient d\'une personne à l\'autre en '
              'fonction de facteurs tels que l\'âge, le niveau d\'activité physique '
              'et le climat. En général, il est recommandé de consommer environ '
              '2 à 3 litres d\'eau par jour pour maintenir une hydratation adéquate.',
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

