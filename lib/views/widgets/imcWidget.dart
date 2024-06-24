import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../calculImc.dart';
class ImcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

        width: 600,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
                    color: const Color(0xFFF4F6FA),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ]
        ),
      child: Column(
        children: [
          SizedBox(height: 10),
            Text("Caluler votre IMC",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 25),
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
                    
                    SizedBox(height: 10),
                    Container(
                      child: Positioned(
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CalculImc()));
                          }, 
                          child: Text("Essayer", style: TextStyle(color: Colors.white,fontSize: 18),),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.withOpacity(.5), // Couleur de fond du bouton
                          //fixedSize: Size(200, 50), // Définir la taille du bouton (hauteur, largeur)
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // Définir le rayon de la bordure
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
