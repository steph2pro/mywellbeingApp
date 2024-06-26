//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:mywellbeing/views/widgets/navBarWidget.dart';

class ExerciceAdd extends StatefulWidget {
  @override
  _ExerciceAddState createState() => _ExerciceAddState();
}
class _ExerciceAddState extends State<ExerciceAdd> {
  
  List<String> items = ['Cardio', 'Strength Training', 'Yoga', 'Pilates'];
  String _selectedItem = 'Cardio';
  final List<String> niveauxDifficultes = [
    'Faible',
    'Moyen',
    'Élevé',
  ];
  String _niveauDifficulte = 'Faible';
  String _nom = '';
  String _content = '';
  bool _isTextContent = true;
  String _dure = '';
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
                  NavBarWidget()
              ]
            ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Ajouter un Exercice',
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
                  labelText: 'Contenu textuel',
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
             SizedBox(height: 20), // Pour ajouter un espace entre les champs
            TextField(
              
              decoration: InputDecoration(
                labelText: 'Durée de l\'exercice (en minute)',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.number, // Pour afficher le clavier numérique
              onChanged: (value) {
                setState(() {
                  _dure= value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'type d\'exercice',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.0),
             Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FA),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],

                    ),
              child: DropdownButton<String>(
                value: _selectedItem,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedItem = value;
                      items.remove(value);
                      items.insert(0, value);
                    });
                  }
                },
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 16.0),
            Text(
              'Niveau de dificulte',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.0),
             Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FA),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],

                    ),
              child: DropdownButton<String>(
                value: _niveauDifficulte,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _niveauDifficulte = value;
                      niveauxDifficultes.remove(value);
                      niveauxDifficultes.insert(0, value);
                    });
                  }
                },
                items: niveauxDifficultes.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),



            
            SizedBox(height: 26.0),
            ElevatedButton(
             
              onPressed: () {
                // Ajoute ici la logique pour sauvegarder l'actualité dans ta base de données
                print('le type choisis est : $_selectedItem');
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
      
        )
      
    );
  }
  
}