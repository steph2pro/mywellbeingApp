import 'package:flutter/material.dart';

class ActualiteAdd extends StatefulWidget {
  @override
  _ActualiteAddState createState() => _ActualiteAddState();
}

class _ActualiteAddState extends State<ActualiteAdd> {
  String _title = '';
  String _description = '';
  String _content = '';
  bool _isTextContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title:
            Row(
              children: [
                Expanded(
                  child: const Text("MY WELLBEING",
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
                'Ajouter une Actualite',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
           TextField(
              decoration: InputDecoration(
                labelText: 'Titre',
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
                  _title = value;
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
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contenu : ',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButton<bool?>(
                    value: _isTextContent,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _isTextContent = value;
                        });
                      }
                    },
                    items: [
                      DropdownMenuItem<bool?>(
                        value: true,
                        child: Text(
                          'Texte',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      DropdownMenuItem<bool?>(
                        value: false,
                        child: Text(
                          'Image',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (_isTextContent)
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contenu texte',
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
                    _content = value;
                  });
                },
                maxLines: null, // Permet un nombre illimité de lignes
              )
            else
              ElevatedButton(
                onPressed: () {
                  // Ajoute ici la logique pour choisir une image depuis la galerie
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.withOpacity(.5), // Couleur de fond du bouton
                   fixedSize: Size(10, 50), // Définir la taille du bouton (hauteur, largeur)
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Définir le rayon de la bordure
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Choisir une image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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