
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
                     Row(
                      children: [
                        //profil
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${message.photo}"),

                        ),
                        //texte a cotee du profil
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          
                          child: Column(
                            children: [
                              Text(
                                message.prenom,
                                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                              ),
                              Text(
                                message.role,
                                style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                              ),
                              
                            ],
                          ),
                        )
                      ]
                    ),


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


          import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywellbeing/views/imagePiker.dart';
import 'dart:typed_data';



class Professionel extends StatefulWidget {
  const Professionel({super.key});

  @override
  State<Professionel> createState() => _ProfessionelState();
}

class _ProfessionelState extends State<Professionel> {

  
  //fonction pour la gestion de l'image
    Uint8List? _image;
  void selectedImage() async{
    Uint8List img =await PickImage(ImageSource.gallery); 
    setState(() {
      _image=img;
    });
  }

   //fonction pour le radio boutton
     String? selectedGender;

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }
  //instanciation de l'objet pour faire les inputs
  CustomTextFied specialiteText=new CustomTextFied(
    title: "specialite",
    placeholder: "entrez votre specialite"
  );
  CustomTextFied horaireText=new CustomTextFied(
    title: "horaire",
    placeholder: "entrez votre horaire de travail"
  );
  CustomTextFied dispoText=new CustomTextFied(
    title: "dispo",
    placeholder: "entrez votre disponibilite"
  );
  CustomTextFied cvText=new CustomTextFied(
    title: "cv",
    placeholder: "entrez votre cv professionel "
  );
  //initialisation de la cle de validation
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    dispoText.err="entez vos disponibilite";
    horaireText.err="entez votre horaire de travail";
    specialiteText.err="entez votre  specialite";
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
        child:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _key,
            child: Column( 
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
          Text('Cremplir votre compte de Professionel de sante',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 30,),
          //code pour l'import d'image
          Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      _image != null ?
                      CircleAvatar(
                        radius:64,
                        backgroundImage:MemoryImage(_image!),
                      )
                      :
                     const CircleAvatar(
                        radius:64,
                        backgroundImage: AssetImage("assets/images/profile.png"),
                      ),
                      Positioned(
                      child: IconButton(
                        onPressed: selectedImage,
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.blueAccent,
                        iconSize: 25,
                    ),
                    bottom: -10,
                    left:80,
                    )
                    ],
                  )
                ],
              )
              ),
          SizedBox(height: 30,),
          specialiteText.textfrofield(),
          //Text('PassWord',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 15,),
          horaireText.textfrofield(),
          SizedBox(height: 15,),
          dispoText.textfrofield(),
          SizedBox(height: 15,),
          cvText.textfrofield(),

      //Text('Genre sélectionné : $selectedGender'),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              // if (_key.currentState?.validate() ?? false) {
              //   //print(dispoText.value);
              //   //print("ok");
              // } else {
                
              // }
              Navigator.push(context, MaterialPageRoute(builder: (context) => PagePincipal()));

            },
            child: Text('enregistrer',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(.7), // Couleur de fond du bouton
            fixedSize: Size(200, 50), // Définir la horaire du bouton (hauteur, largeur)
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Définir le rayon de la bordure
            ),
           ),
          ),
          
        ],),
            )
        )
      ),)
    );
  }
}