import 'package:flutter/material.dart';

class SportText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'L\'importance du Sport',
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
              'Le Sport',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour le titre principal
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Le sport est une activité physique pratiquée dans un cadre organisé '
              'ou non, dans le but d améliorer sa condition physique et mentale. '
              'Il englobe une grande variété de disciplines et dactivités, allant '
              'des sports individuels comme la course à pied et la natation, aux '
              'sports collectifs tels que le football et le basketball.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte principal
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienfaits du Sport',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour les titres des sections
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Amélioration de la santé cardiovasculaire et respiratoire',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte des éléments de liste
              ),
            ),
            Text(
              '- Renforcement des muscles et des os',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Réduction du risque de maladies chroniques comme le diabète et les maladies cardiaques',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Gestion du poids et amélioration de la composition corporelle',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            Text(
              '- Promotion du bien-être mental et réduction du stress',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Importance de la Pratique Régulière',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'La pratique régulière d\'une activité sportive est essentielle pour '
              'en maximiser les bienfaits. Il est recommandé de trouver un sport '
              'ou une activité physique que l\'on aime, afin de maintenir une '
              'motivation élevée et de favoriser une adoption à long terme.',
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
