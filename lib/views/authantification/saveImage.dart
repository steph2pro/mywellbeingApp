
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/professionel.dart';

import 'package:mywellbeing/views/profil.dart';

class SaveImage extends StatelessWidget {
  const SaveImage({super.key});
  void selectedImage(){
    
  }
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
      body: Center(
        child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 64,
                  backgroundImage:AssetImage("assets/images/accueil.jpg")
                ),
                Positioned(
                  child: IconButton(onPressed: selectedImage, 
                  icon: Icon(Icons.add_a_photo)
                  ),
                  bottom: -20,
                  left: 80,
                  )
              ],
            )
          ],
        ),
        
      
      
      )
    );
  }
}