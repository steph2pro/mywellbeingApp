import 'package:flutter/material.dart';


class RationAdd extends StatefulWidget {
  @override
  _RationAddState createState() => _RationAddState();
}

final List<String> recettes = [
  'Tarte fine aux tomates',
  'Saumon en croûte de noix',
  'Crumble de pommes à la cannelle',
  // Ajoute d'autres recettes si nécessaire
];

class _RationAddState extends State<RationAdd> {
  String _titre = '';
  String _description = '';
  String _contenue = '';
  List<String> _recettesSelectionnees = [];

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
      body:SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Ajouter une Ration alimentaire',
                style: TextStyle(
                  fontSize: 22.0,
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
                  _titre = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'contenue',
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
                  _contenue = value;
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
            // liste de recette
            SizedBox(height: 16.0),
            Text(
              'Recettes',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: recettes.length,
              itemBuilder: (context, index) {
                final recette = recettes[index];
                return CheckboxListTile(
                  title: Text(recette),
                  value: _recettesSelectionnees.contains(recette),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value) {
                        _recettesSelectionnees.add(recette);
                      } else {
                        _recettesSelectionnees.remove(recette);
                      }
                    });
                  },
                );
              },
            ),


            SizedBox(height: 26.0),
            ElevatedButton(
             
              onPressed: () {
                // Ajoute ici la logique pour sauvegarder l'actualité dans ta base de données
                
                 print('Recettes sélectionnées: $_recettesSelectionnees');
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