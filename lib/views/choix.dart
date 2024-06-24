
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/professionel.dart';

import 'package:mywellbeing/views/profil.dart';
import 'package:mywellbeing/views/calculImc.dart';
class Choix extends StatelessWidget {
  const Choix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Well being",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: Container(
        
        
          // decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/accueil.jpg"),
          //   fit: BoxFit.fitWidth,
            
          // ),
          // ),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/accueil.jpg', // Assurez-vous de placer votre image dans le dossier "assets"
              width: 500,
              height: 300,
              //fit: BoxFit.fitWidth,
            ),
            Padding(padding: const EdgeInsets.only(top:5),
            child: Text(
              'Vous voulez continuer en tant que :',
              style: TextStyle(fontSize: 20,color: Colors.blueAccent),
              textAlign: TextAlign.center,
              
            ),),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profil()));
              },
              child: Text('utilisateur ',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(.7), // Couleur de fond du bouton
            fixedSize: Size(300, 50), // Définir la taille du bouton (hauteur, largeur)
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Définir le rayon de la bordure
            ),
           ),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
           ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Professionel()));
              },
              child: Text('professionel',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(.7), // Couleur de fond du bouton
            fixedSize: Size(300, 50), // Définir la taille du bouton (hauteur, largeur)
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Définir le rayon de la bordure
            ),
           ),
            )
              ],
            )
        
          ],
          
        ),
        
      
      
      )
    );
  }
}