import 'package:flutter/material.dart';
import 'package:mywellbeing/views/DailyDietView.dart';

class Planregime extends StatelessWidget {
  // Liste de données pour chaque jour
  final List<Map<String, dynamic>> daysData = List.generate(30, (index) {
    return {
      'day': 'Jour ${index + 1}',
      'imagePath': 'assets/images/nutrition_sportive.jpg', // Chemin de l'image
    };
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmes Alimentaires'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0, // Aspect ratio of each grid item
        ),
        itemCount: daysData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Naviguer vers DailyDietView.dart lorsque la carte est cliquée
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyDietView(),
                ),
              );
            },
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  Image.asset(
                    daysData[index]['imagePath'],
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8.0),
                  // Texte du jour
                  Text(
                    daysData[index]['day'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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
