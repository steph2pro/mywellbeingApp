import 'package:flutter/material.dart';
class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}
class _NotificationListState extends State<NotificationList> {
 
  final List<Map<String, String>> notifications = [
    {
      "title": "Hydratez-vous",
      "body": "N'oubliez pas de boire de l'eau !",
      "time": "10:00 AM",
      "date": "2024-06-26"
    },
    {
      "title": "Exercice physique",
      "body": "Il est temps de faire un peu d'exercice. Une petite marche de 10 minutes peut faire des merveilles.",
      "time": "11:00 AM",
      "date": "2024-06-26"
    },
    {
      "title": "Méditez",
      "body": "Prenez 5 minutes pour méditer et recentrer votre esprit.",
      "time": "2:00 PM",
      "date": "2024-06-26"
    },
    {
      "title": "Prenez vos vitamines",
      "body": "N'oubliez pas de prendre vos suppléments vitaminiques.",
      "time": "4:00 PM",
      "date": "2024-06-26"
    },
    {
      "title": "Préparez-vous pour le sommeil",
      "body": "Commencez à vous préparer pour une bonne nuit de sommeil. Éteignez les écrans et détendez-vous.",
      "time": "9:00 PM",
      "date": "2024-06-26"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
           style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
            ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifications[index]["title"]!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      notifications[index]["body"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${notifications[index]["time"]!} - ${notifications[index]["date"]!}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
