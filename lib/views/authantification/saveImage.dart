
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

  // Expanded(
          //   child: ListView.builder(
          //     itemCount: Actualites.length,
          //     itemBuilder: (context, index) {
          //       return Container(
          //   margin: EdgeInsets.all(10),

          //   padding: EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //               color: const Color(0xFFF4F6FA),
          //               borderRadius: BorderRadius.circular(10),
          //               boxShadow: const [
          //                 BoxShadow(
          //                   color: Colors.black12,
          //                   blurRadius: 4,
          //                   spreadRadius: 2,
          //                 ),
          //               ],
          //             ),
          //   //la photo de profil , le texte a cotee
          //   child: Column(
          //     children: [
                
          //       Row(
          //         children: [
          //           //profil
          //           CircleAvatar(
          //             radius: 35,
          //             backgroundImage: AssetImage(Actualites[index].profil),

          //           ),
          //           //texte a cotee du profil
          //           Container(
          //             margin: EdgeInsets.only(left: 10),
                      
          //             child: Column(
          //               children: [
          //                 Text(
          //                   Actualites[index].name,
          //                   style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
          //                 ),
          //                 Text(
          //                   Actualites[index].role,
          //                   style: TextStyle(fontSize: 17,color: Colors.grey[700]),
          //                 ),
                          
          //               ],
          //             ),
          //           )
                    

          //         ],
          //       ),
          //       //texte descriptif de l'actualite
          //       Container(
          //         margin: EdgeInsets.all( 10),
          //         child: Text(
          //            Actualites[index].description,
          //            style: TextStyle(fontSize: 17,color: Colors.grey[700]),
          //          ),
          //       ),
          //       //l'image au millieur
          //      Container(
          //         width: 400,
          //         height: 200,
          //          decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: AssetImage(Actualites[index].imageUrl),
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //       ),
          //       //les icones et le texte en bas
          //       Container(
          //         margin: EdgeInsets.only(top: 20),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical au centre
          //           crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal au centre
          //           mainAxisSize: MainAxisSize.min, // Réduit la taille de la colonne à son contenu
                    
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement équitable entre les icônes et le texte
          //               children: [
          //                 Column(
          //                   children: [
          //                     Icon(Icons.thumb_up, color: Colors.green),
          //                     Text("Liker", style: TextStyle(color: Colors.green)),
          //                   ],
          //                 ),
          //                 Column(
          //                   children: [
          //                     Icon(Icons.comment, color: Colors.green),
          //                     Text("Commenter", style: TextStyle(color: Colors.green)),
          //                   ],
          //                 ),
          //                 Column(
          //                   children: [
          //                     Icon(Icons.share, color: Colors.green),
          //                     Text("Partager", style: TextStyle(color: Colors.green)),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // );
          //     },
          //   ),
          // ),