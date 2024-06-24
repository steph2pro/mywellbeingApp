import 'package:flutter/material.dart';

class RecetteAdd extends StatefulWidget {
  @override
  _RecetteAddState createState() => _RecetteAddState();
}

class _RecetteAddState extends State<RecetteAdd> {
  String _nom = '';
  String _description = '';
  String _propriete = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title:
            Row(
              children: [
                Expanded(
                  child: const Text("Programme",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  profilPlus
              ]
            ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Ajouter une Recette',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
           TextField(
              decoration: InputDecoration(
                labelText: 'Nom',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  _nom = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'propriete',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  _propriete = value;
                });
              },
            ),
            SizedBox(height: 16.0),
             TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 26.0),
            ElevatedButton(
             
              onPressed: () {
                // Ajoute ici la logique pour sauvegarder l'actualité dans ta base de données
              },
             child: Text('Ajouter',
               style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
             ),
             style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Couleur de fond du bouton
                   fixedSize: Size(10, 50), // Définir la taille du bouton (hauteur, largeur)
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Définir le rayon de la bordure
                  ),
                ),
            ),
          ],
        ),
      ),
      
    );
  }
  
}
Widget profilPlus = Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            radius: 20,
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de recherche
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de notification
            },
          ),
        ],
      ),
    );