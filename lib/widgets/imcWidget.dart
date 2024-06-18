import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 600,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(249, 66, 158, 1.0),
            Color.fromRGBO(249, 66, 158, 1.0),
            Colors.green,
          ],
        ),
        //color: Color.fromARGB(255, 243, 104, 150),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
            Text("Caluler votre IMC",
              style: TextStyle(color: Colors.white,fontSize: 30),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Column(
                children: [
                Column(
                mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Positioned(
                      width: 700,
                      height: 200,
                      child: 
                          Image.asset("assets/images/imc.jpg"),
                    ),
                    //SizedBox(width: 20),
                    Container(
                      child: Positioned(
                        child: ElevatedButton(
                          onPressed: (){}, 
                          child: Text("Essayer", style: TextStyle(color: Colors.white,fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellowAccent.withOpacity(.7), // Couleur de fond du bouton
                          //fixedSize: Size(200, 50), // Définir la taille du bouton (hauteur, largeur)
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1), // Définir le rayon de la bordure
                          ),
                        ),
                          )
                      ),
                    ),
                    
                  ],
                ),
                
                ]
              )
          ]
      ),
    );
  }
}
