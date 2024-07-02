import 'package:flutter/material.dart';

class Program {
  final String name;
  final String imageUrl;
  final String description;

  Program({required this.name, required this.imageUrl, required this.description});
}

class Recherche extends StatefulWidget {
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {
  final List<Program> programs = [
    Program(
      name: "Programme de régime",
      imageUrl: "assets/images/regime.jpg",
      description: "Perdez jusqu'à 7kg en 1 mois",
    ),
    Program(
      name: "Programme sportif",
      imageUrl: "assets/images/sport.jpg",
      description: "Bougez et maintenez-vous en forme",
    ),
    Program(
      name: "Programme de méditation",
      imageUrl: "assets/images/reg6.jpg",
      description: "Réduisez le stress et améliorez votre bien-être",
    ),
    Program(
      name: "Programme de nutrition",
      imageUrl: "assets/images/reg4.jpg",
      description: "Adoptez une alimentation saine et équilibrée",
    ),
    // Ajoutez d'autres programmes ici
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    // Logique de la recherche
    List<Program> filteredPrograms = programs.where((program) {
      final programNameLower = program.name.toLowerCase();
      final programDescriptionLower = program.description.toLowerCase();
      final queryLower = query.toLowerCase();

      return programNameLower.contains(queryLower) || programDescriptionLower.contains(queryLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recherche',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montseraat',
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Rechercher un programme',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
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
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.asset(
                            filteredPrograms[index].imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(filteredPrograms[index].name),
                          subtitle: Text(filteredPrograms[index].description),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
