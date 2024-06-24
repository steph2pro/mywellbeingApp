// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/programmeList.dart';

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

// ignore: use_key_in_widget_constructors
class MyProfile extends StatelessWidget{
  //lis des images
  List<String> mesImg = [
    "assets/images/exercice1.gif",
    "assets/images/exercice2.gif",
    "assets/images/exercice3.gif",
    "assets/images/exercice4.gif",
  ];
   List<String> imgs = ['doctor1.jpg', 'doctor2.jpg', 'doctor3.jpg', 'doctor4.jpg'];
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
@override
   Widget build(BuildContext context){
    return   Scaffold(
      backgroundColor: const Color(0xFF7165D6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //       child: const Icon(
                //         Icons.arrow_back_ios_new,
                //         color: Colors.white,
                //         size: 25,
                //       ),
                //     ),

                //     InkWell(
                //       onTap: () {
                //         Navigator.pop(context);
                //       },
                //       child: const Icon(
                //         Icons.more_vert,
                //         color: Colors.white,
                //         size: 25,
                //       ),
                //     ),
                //   ],
                //  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(radius: 35,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Stephane Pro",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Utilisateur",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9F97E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.help,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9F97E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9F97E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 0.9,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Informations Personaliser",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "vos activiter et vos programme suivie sont les suivants:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Programme alimentaire suivi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star , color: Colors.amber),
                      const Text(
                        "4.9",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(
                    height: 200,
                    width: 600,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      // childAspectRatio: 0.75, 
                      itemCount: programs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                           width: 300,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(vertical:5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                             boxShadow:const [
                              BoxShadow(
                              color:Colors.black12,
                              blurRadius:4,
                              spreadRadius: 2,
                            ),
                             ],
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width /1.4,
                            child:  Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                   backgroundImage: Image.asset(programs[index].imageUrl).image,
                                  ),
                                  title:  Text(
                                    programs[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: const Text("il ya un jour"),
                                  trailing: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "3.9",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                    ),
                                ),

                                const SizedBox(height: 5),
                                 Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child:  Text(
                                    programs[index].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Programme Sportif suivi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star , color: Colors.amber),
                      const Text(
                        "4.9",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: mesImg.length,
          itemBuilder: (context, index) {
            String monImg = mesImg[index];
            return Container(
              width: 200,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                             boxShadow:const [
                              BoxShadow(
                              color:Colors.black12,
                              blurRadius:4,
                              spreadRadius: 2,
                            ),
                             ],
                          ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(monImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
                  const SizedBox(height: 10),
                  const Text(
                    "Localisation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0EEFA),
                        shape: BoxShape.circle,
                        ),
                        child:const Icon(
                          Icons.location_on,
                          color: Color(0xFF7165D6),
                        )
                    ),
                    title: const Text(
                      "BAFOUSSAM, Quatier AWoussa",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text("adresse de residence"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //code pour le boutton flotant
       floatingActionButton: FloatingActionButton(
        onPressed: (){
         // Navigator.push(context, MaterialPageRoute(builder: (context) => ActualiteAdd()));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.blueAccent, // Définit la couleur du bouton en bleu
        foregroundColor: Colors.white, // Définit la couleur de l'icône en blanc
        child: const Icon((Icons.edit),
      ),
      )
    );
   }
}