import 'package:flutter/material.dart';


class ProgrammeAdd extends StatefulWidget {
  @override
  _ProgrammeAddState createState() => _ProgrammeAddState();
}

final List<String> rations = [
  'Menu équilibré',
  'Régime riche en nutriments',
  'Plan de repas énergétique',
  // Ajoute d'autres rations si nécessaire
];
final List<String> seances = [
  'Entraînement cardio',
  'Séance d\'entraînement en force',
  'Séance de yoga apaisante',
  // Ajoute d'autres rations si nécessaire
];
  final List<String> typeProgrammes = [
    'Programme de remise en forme',
    'Programme de perte de poids',
    'Programme de méditation',
    'Programme de nutrition',
    'Programme de sommeil'
  ];
  String _typeProgramme = 'Programme de remise en forme';

class _ProgrammeAddState extends State<ProgrammeAdd> {
  String _nom = '';
  String _description = '';
  String _contenue = '';
  List<String> _rationsSelectionnees = [];
  List<String> _seancesSelectionnees = [];

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
      body: SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'construire un programme',
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
                  _nom = value;
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
            Text(
              'Type de programme',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10.0),
             Container(
              width: 4000,
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
                value: _typeProgramme,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _typeProgramme = value;
                      typeProgrammes.remove(value);
                      typeProgrammes.insert(0, value);
                    });
                  }
                },
                items: typeProgrammes.map((String item) {
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


            // liste de rations
            SizedBox(height: 16.0),
            Text(
              'ration alimentaire',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: rations.length,
              itemBuilder: (context, index) {
                final recette = rations[index];
                return CheckboxListTile(
                  title: Text(recette),
                  value: _rationsSelectionnees.contains(recette),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value) {
                        _rationsSelectionnees.add(recette);
                      } else {
                        _rationsSelectionnees.remove(recette);
                      }
                    });
                  },
                );
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Seance d\'entrainement',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: seances.length,
              itemBuilder: (context, index) {
                final seance = seances[index];
                return CheckboxListTile(
                  title: Text(seance),
                  value: _seancesSelectionnees.contains(seance),
                  onChanged: (value) {
                    setState(() {
                      if (value != null && value) {
                        _seancesSelectionnees.add(seance);
                      } else {
                        _seancesSelectionnees.remove(seance);
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
                
                 print('rations sélectionnées: $_rationsSelectionnees');
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