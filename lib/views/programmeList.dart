import 'package:flutter/material.dart';
import 'package:mywellbeing/views/DailyDietView.dart';
import 'package:mywellbeing/views/programme/choixElement.dart';
import 'package:mywellbeing/views/programme/programmeAdd.dart'; // Importer la classe DailyDietView du fichier externe

// Modèle de données pour représenter un programme
class Program {
  final String name;
  final String imageUrl;
  final String description;

  Program({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

// Page affichant la liste des programmes
class ProgrammeList extends StatelessWidget {
  final List<Program> programs = [
    Program(
      name: "Programme de regime",
      imageUrl: "assets/images/regime.jpg", // URL en tant que ressource locale
      description: "Perder jusqu'a 7kg en 1mois",
    ),
    Program(
      name: "Programme sportif",
      imageUrl: "assets/images/sport.jpg", // URL en tant que ressource locale
      description: "bouger et maintenez vous en forme",
    ),
    Program(
      name: "Programme de regime",
      imageUrl: "assets/images/regime.jpg", // URL en tant que ressource locale
      description: "Perder jusqu'a 7kg en 1mois",
    ),
    Program(
      name: "Programme sportif",
      imageUrl: "assets/images/sport.jpg", // URL en tant que ressource locale
      description: "bouger et maintenez vous en forme",
    ),
    // Ajoutez d'autres programmes ici
  ];

  final List<String> categories = [
    'fitness ',
    'nutrition ',
    'gestion du stress',
    'santé mentale ',
    // Ajoutez d'autres catégories si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Programmes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un programme',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                // Logique de recherche
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' Catégories de programme :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FA),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                    ),
                    child: Center(
                      child: Text(categories[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      )
                      ),
                    )
                  );
                //  Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 4.0),
                //   child: Chip(
                //     label: Text(categories[index]),
                //     // Ajoutez des styles ou des actions aux chips si nécessaire
                //   ),
                // );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Programmes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: programs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        // Navigation vers une autre page lorsqu'un programme est tapé
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DailyDietView(),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.asset(programs[index].imageUrl), // Utilisation de la ressource locale
                        title: Text(programs[index].name),
                        subtitle: Text(programs[index].description),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      //code pour le boutton flotant
      //  floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => ChoixElement()));
      //   },
      //   tooltip: 'Increment',
      //   backgroundColor: Colors.blueAccent, // Définit la couleur du bouton en bleu
      //   foregroundColor: Colors.white, // Définit la couleur de l'icône en blanc
      //   child: const Icon((Icons.add_circle),
      // ),
      // ),

      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChoixElement()));
              },
              tooltip: 'ajouter',
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add_circle,size: 30,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProgrammeAdd()));

                },
                tooltip: 'construire',
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
                
                child: const Icon(Icons.self_improvement,size: 40,),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
