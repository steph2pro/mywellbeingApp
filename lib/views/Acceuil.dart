
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/homePage.dart';
import 'package:image_picker/image_picker.dart';
class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child:  Text(
      //     "My Well being",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.blueAccent[400],
      //     ),
      //   ),),
      // ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/accueil.jpg"),
          //   fit: BoxFit.fitWidth,
          // )
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(top:60),
            child: Text(
              'Bienvenue sur My WellBeing !',
              style: TextStyle(fontSize: 30,color: Colors.blueAccent),
              textAlign: TextAlign.center,
              
            ),),
            Padding(padding: const EdgeInsets.only(top:10),
            child: Text(
              'Votre Application de santé et bien-être!',
              style: TextStyle(fontSize: 20,),
              
            ),),
            Padding(padding: const EdgeInsets.only(top:10),
            child: Text(
              'Votre bien-être, notre priorité !',
              style: TextStyle(fontSize: 18,),
              
            ),),
            SizedBox(height: 20),
            Container(
                  width: 400,
                  height: 300,
                   decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/accueil.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 20)),
                ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text('Commencer',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(.7), // Couleur de fond du bouton
            fixedSize: Size(200, 50), // Définir la taille du bouton (hauteur, largeur)
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Définir le rayon de la bordure
            ),
           ),
            )
              ],
            )
        
          ],
          
        ),
        
      ),
      
      )
    );
  }
}