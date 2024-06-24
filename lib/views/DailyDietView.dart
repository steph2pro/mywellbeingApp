import 'package:flutter/material.dart';

class Food {
  final String name;
  final String imageUrl;
  final String description;
  final String calories;
  final String preparation;

  Food({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.calories,
    required this.preparation,
  });
}

class DailyDietView extends StatelessWidget {
  final List<Food> meals = [
    Food(
      name: "Petit déjeuner",
      imageUrl: "assets/images/reg1.jpg",
      description: "Pain complet, œufs brouillés, avocat et jus d'orange",
      calories: "450",
      preparation: "Préparation : Mélanger les œufs, cuire dans une poêle chaude, servir avec du pain complet et de l'avocat. Presser le jus d'orange.",
    ),
    Food(
      name: "Déjeuner",
      imageUrl: "assets/images/reg2.jpg",
      description: "Salade verte avec poulet grillé, tomates et vinaigrette",
      calories: "350",
      preparation: "Préparation : Griller le poulet, couper en morceaux, mélanger avec la salade et les tomates, assaisonner avec de la vinaigrette.",
    ),
    Food(
      name: "Collation de l'après-midi",
      imageUrl: "assets/images/reg3.jpg",
      description: "Yaourt grec avec des baies fraîches",
      calories: "150",
      preparation: "Préparation : Verser le yaourt dans un bol, ajouter les baies fraîches et mélanger.",
    ),
    Food(
      name: "Dîner",
      imageUrl: "assets/images/reg4.jpg",
      description: "Poisson grillé avec légumes sautés",
      calories: "400",
      preparation: "Préparation : Griller le poisson, faire sauter les légumes dans une poêle chaude, servir ensemble.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
        title: Text('Programme du jour',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meals[index].name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    meals[index].description,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Calories: ${meals[index].calories} kcal',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    meals[index].preparation,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8.0),
                  Image.asset(
                    meals[index].imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
