import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywellbeing/pagePincipal.dart';
import 'package:mywellbeing/widgets/customTextFied.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywellbeing/imagePiker.dart';
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
          Text('Creer compte de Professionel de sante',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
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