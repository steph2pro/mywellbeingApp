import 'package:flutter/material.dart';

class MeditationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienfaits de la Méditation',
          style: TextStyle(color: Colors.white), // Couleur blanche pour le titre de l'appbar
        ),
        backgroundColor: Colors.blue, // Couleur de fond de l'appbar
      ),
      backgroundColor: Colors.white, // Couleur de fond de l'écran
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'La Méditation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour le titre principal
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'La méditation est une pratique ancestrale qui vise à entraîner l\'esprit '
              'et à atteindre un état de clarté mentale et de tranquillité intérieure. '
              'Elle est souvent associée à la relaxation et à la réduction du stress, mais '
              'elle offre également de nombreux autres bienfaits pour la santé mentale et '
              'physique.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte principal
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Bienfaits de la Méditation',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Couleur blanche pour les titres des sections
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Réduction du stress et de l\'anxiété',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black, // Couleur du texte des éléments de liste
              ),
            ),
            Text(
              '- Amélioration de la concentration et de la clarté mentale',
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
              '- Promotion du bien-être émotionnel',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Comment Méditer',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'La méditation peut être pratiquée de différentes manières, '
              'comme la méditation guidée, la pleine conscience (mindfulness), '
              'ou la méditation transcendantale. Trouvez une méthode qui vous '
              'convient et pratiquez régulièrement pour en ressentir les bienfaits.',
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
