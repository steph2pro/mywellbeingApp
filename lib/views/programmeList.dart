import 'package:flutter/material.dart';
import 'package:mywellbeing/views/DailyDietView.dart';
import 'package:mywellbeing/views/programme/choixElement.dart';
import 'package:mywellbeing/views/programme/programmeAdd.dart';

class Program {
  final String name;
  final String imageUrl;
  final String description;
  final String type;

  Program({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.type,
  });
}

class ProgrammeList extends StatefulWidget {
  @override
  _ProgrammeListState createState() => _ProgrammeListState();
}

class _ProgrammeListState extends State<ProgrammeList> {
  final List<Program> programs = [
    Program(
      name: "Programme de musculation",
      imageUrl: "assets/images/sport.jpg",
      description: "Augmentez votre force et développez votre masse musculaire.",
      type: "Sportif",
    ),
    Program(
      name: "Programme de course à pied",
      imageUrl: "assets/images/sport.jpg",
      description: "Améliorez votre endurance et brûlez des calories en courant.",
      type: "Sportif",
    ),
    Program(
      name: "Programme de yoga",
      imageUrl: "assets/images/sport.jpg",
      description: "Renforcez votre corps et votre esprit avec des exercices de yoga.",
      type: "Sportif",
    ),
    Program(
      name: "Programme de perte de poids",
      imageUrl: "assets/images/perte_poids.jpg",
      description: "Un plan nutritionnel pour perdre du poids de manière saine et équilibrée.",
      type: "Nutrition",
    ),
    Program(
      name: "Programme de renforcement musculaire",
      imageUrl: "assets/images/renforcement.jpg",
      description: "Un régime alimentaire pour stimuler la croissance musculaire et la récupération.",
      type: "Nutrition",
    ),
    Program(
      name: "Programme de nutrition sportive",
      imageUrl: "assets/images/nutrition_sportive.jpg",
      description: "Un guide alimentaire pour optimiser les performances lors de l'entraînement sportif.",
      type: "Nutrition",
    ),
    Program(
      name: "Programme de relaxation",
      imageUrl: "assets/images/sport.jpg",
      description: "Des exercices de respiration et de méditation pour réduire le stress et favoriser la détente.",
      type: "Gestion du stress",
    ),
    Program(
      name: "Programme de gestion du temps",
      imageUrl: "assets/images/nutrition_sportive.jpg",
      description: "Des techniques de planification et d'organisation pour gérer le stress lié aux deadlines et aux responsabilités.",
      type: "Gestion du stress",
    ),
    Program(
      name: "Programme d'hydratation",
      imageUrl: "assets/images/nutrition_sportive.jpg",
      description: "Un plan pour assurer une hydratation adéquate tout au long de la journée et maintenir une bonne santé.",
      type: "Hydratation",
    ),
  ];

  final List<String> types = [
    'Sportif',
    'Nutrition',
    'Gestion du stress',
    'Hydratation',
  ];

  String selectedType = 'Sportif'; // Variable d'état pour le type sélectionné
  String searchText = ''; // Variable d'état pour le texte de recherche

  @override
  Widget build(BuildContext context) {
    List<Program> filteredPrograms = programs.where((program) {
      return program.type == selectedType &&
          (program.name.toLowerCase().contains(searchText.toLowerCase()) ||
              program.description.toLowerCase().contains(searchText.toLowerCase()));
    }).toList();

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
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Type de programme:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: types.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = types[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                      color: selectedType == types[index] ? Colors.blue : Color(0xFFF4F6FA),
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
                      child: Text(
                        types[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: selectedType == types[index] ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                );
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
            child: filteredPrograms.isEmpty
                ? Center(
                    child: Text(
                      'Aucun élément trouvé',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPrograms.length,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DailyDietView(),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: Image.asset(filteredPrograms[index].imageUrl),
                              title: Text(filteredPrograms[index].name),
                              subtitle: Text(filteredPrograms[index].description),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
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
              child: const Icon(Icons.add_circle, size: 30),
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
                child: const Icon(Icons.self_improvement, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
