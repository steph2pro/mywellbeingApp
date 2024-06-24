import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywellbeing/views/imagePiker.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  //fonction pour la gestion de l'image
    Uint8List? _image;
    String _imagepath="";
  void selectedImage() async{
    Uint8List img =await PickImage(ImageSource.gallery); 
    setState(() {
      _image=img;
      //print("mon image est: $_image");
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadImage();
  }
  //fonction pour enregistrer l'image
  void saveImage(path) async{
    SharedPreferences saveImg= await SharedPreferences.getInstance();
    saveImg.setString("imagepath", path);
  }
  void LoadImage()async{
    SharedPreferences saveImg= await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImg.getString("imagepath")!;
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
  CustomTextFied ageText=new CustomTextFied(
    title: "age",
    placeholder: "entrez votre age"
  );
  CustomTextFied tailleText=new CustomTextFied(
    title: "taille",
    placeholder: "entrez votre taille"
  );
  CustomTextFied poidsText=new CustomTextFied(
    title: "poids",
    placeholder: "entrez votre poids"
  );
  //initialisation de la cle de validation
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    poidsText.err="entez le poids";
    tailleText.err="entez le taille";
    ageText.err="entez le age";
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
          Text('Creer votre profil utilisateur',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
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
                        backgroundImage: MemoryImage(_image!),
                      )
                      :
                     const CircleAvatar(
                    
                        radius:64,
                        backgroundImage: AssetImage("assets/images/profile.png"),
                      ),
                      Positioned(
                        width: 40,
                        height: 70,
                      child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueAccent,
                          child: IconButton(
                            onPressed: selectedImage,
                            //changer d'icon si une image est selectionner
                            icon: _image !=null ?
                              const Icon(Icons.check):
                              const Icon(Icons.add_a_photo),
                            color: Colors.white,
                            iconSize: 25,
                          ),
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
          ageText.textfrofield(),
          //Text('PassWord',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 15,),
          tailleText.textfrofield(),
          SizedBox(height: 15,),
          poidsText.textfrofield(),
          SizedBox(height: 15,),

      //Text('Genre sélectionné : $selectedGender'),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              // if (_key.currentState?.validate() ?? false) {
              //   //print(poidsText.value);
              //   //print("ok");
              // } else {
                
              // }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => PagePincipal()));
                saveImage(_imagepath);
                print(_imagepath);

            },
            child: Text('enregistrer',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withOpacity(.7), // Couleur de fond du bouton
            fixedSize: Size(200, 50), // Définir la taille du bouton (hauteur, largeur)
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