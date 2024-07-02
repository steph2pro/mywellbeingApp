import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywellbeing/views/choix.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mywellbeing/views/widgets/loading.dart';
class Register extends StatefulWidget {
  //const Register({super.key});
  //fonction visible pour basculer de la page Register a la page register
   final VoidCallback toggle;

  Register({required this.toggle});
  // final Function visible;
  // Register(this.visible);
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

   String erreur="";
   bool _loading=false;
//creation de la fonction pour enregistrer les utilisateurs
void creationCompte (String nom, String prenom, String email,String pass, String action,String? sexe) async{
   setState((){
      erreur="";
      _loading=true;
    });
   try { 
    //on utilise la methode post pour envoyer les donne 
    //on entre d'adord l'url et par la suite les donne a envoyer sous forme de cle-valeur notament dans le body
    final response= await http.post(Uri.parse("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/userViewmodel.php"),body: {
      "nom":nom,
      "prenom":prenom,
      "email":email,
      "pass":pass,
      "action":action,
      "sexe":sexe
    });
    //on fait une condition pour voir si la requette as ete executer normalement
    if (response.statusCode==200) {
      var data=jsonDecode(response.body);
      print(data);
      var result=data['data'];
      int succes=result["success"];
      print(succes);
      if(succes==1){
        setState((){
          _loading=false;
          erreur=result["message"];
        });
      }else{
         setState((){
          print(result["message"]);
          erreur=result["message"];
          _loading=false;
        });

      }
    } else {
        print("Erreur de connexion : ${response.statusCode}");
        print("error: ${response.body}");
    }
  } catch (error) {
    print("Erreur de connexion : $error");
    
  }
}





   //fonction pour le radio boutton
     String? selectedGender;

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }
  //instanciationde l'objet pour faire les inputs
  CustomTextFied nomText=new CustomTextFied(
    title: "nom",
    placeholder: "entrez votre nom"
  );
  CustomTextFied prenomText=new CustomTextFied(
    title: "prenom",
    placeholder: "entrez votre prenom"
  );
  CustomTextFied emailText=new CustomTextFied(
    title: "email",
    placeholder: "entrez votre adresse mail"
  );
  CustomTextFied passText=new CustomTextFied(
    title: "mot de pass",
    placeholder: "entrez votre mot de pass",
    ispass: true,
    );
  // CustomTextFied villeText=new CustomTextFied(
  //   title: "Ville de residence",
  //   placeholder: "entrez votre ville de residence",
  //   ispass: true,
  //   );
  //initialisation de la cle de validation
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    emailText.err="entez l'email";
    passText.err="entrez le mot de pass";
    return _loading ? Loading()
    :Scaffold(
      body: Center( 
        child:  SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Form(
            key: _key,
            child: Column( 
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
          Text('Creer un compte',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 30,),
          nomText.textfrofield(),
          //Text('PassWord',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 15,),
          prenomText.textfrofield(),
          SizedBox(height: 15,),
          emailText.textfrofield(),
          SizedBox(height: 15,),
          passText.textfrofield(),
          SizedBox(height: 15,),
          //villeText.textfrofield(),
          SizedBox(height: 15,),
  //      radio button

          Text('Sélectionnez votre genre :'),
          Row(
        children: [
          Row(
            children: [
              Radio(
                value: 'Masculin',
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
              Text('Masculin'),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'Feminin',
                groupValue: selectedGender,
                onChanged: onGenderChanged,
              ),
              Text('Féminin'),
            ],
          ),
          
        ],
      ),
      //Text('Genre sélectionné : $selectedGender'),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              if (_key.currentState?.validate() ?? false) {
                creationCompte(nomText.value, prenomText.value, emailText.value, passText.value,"create",selectedGender);
                // print(selectedGender);
                // print("ok");
              } else {
                
              }
             // Navigator.push(context, MaterialPageRoute(builder: (context) => Choix()));
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("avez vous un compte? "),
              TextButton(
              onPressed: widget.toggle,
              child: Text('Connectez-vous', style: TextStyle(fontSize: 15, color:Colors.blueAccent),),
            ),
            ],
            
          ),
          SizedBox(height: 30,),
          Text(
                erreur,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
        ],),
            )
        )
      ),)
    );
  }
}