import 'package:flutter/material.dart';
import 'package:mywellbeing/views/programme/recetteAdd.dart';
import 'package:mywellbeing/views/programme/rationAdd.dart';
import 'package:mywellbeing/views/programme/exerciceAdd.dart';
import 'package:mywellbeing/views/programme/seanceAdd.dart';

// Page affichant la liste des programmes
class ChoixElement extends StatefulWidget {
  const ChoixElement({super.key});

  @override
  State<ChoixElement> createState() => _ChoixElementState();
}
class _ChoixElementState extends State<ChoixElement> {
  

  final List<String> categories = [
    ' Une recette ',
    'Une Ration Alimentaire ',
    'Un Exercice ',
    'Une Seance d\'entrenement ',
    // Ajoutez d'autres catégories si nécessaire
  ];
   final  liens = [
    RecetteAdd(),
    RationAdd(),
    ExerciceAdd(),
    SeanceAdd(),
  ];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' Vous voulez  Ajouter ? :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height /1.5,
            
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Action à effectuer lorsqu'un élément est cliqué
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => liens[index], // Redirige vers la page DetailProgram
                      ),
                    );
                  },
                  child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
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
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      )
                      ),
                    )
                  )
                );
              },
            ),
          ),
          
        ],
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




    