import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywellbeing/crypte/encrypte.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:http/http.dart' as http;
import 'package:mywellbeing/views/widgets/loading.dart';
class Login extends StatefulWidget {
  //const Login({super.key});
  //fonction visible pour basculer de la page Register a la page register
 final VoidCallback toggle,login;
// final VoidCallback toggle;

  Login({required this.toggle,required this.login});

  // final Function visible;
  // Login(this.visible);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   String erreur="";
   bool _loading=false;
  void login(String nom, String pass, String action) async {
    setState((){
      erreur="";
      _loading=true;
    });
  try { 
    //on utilise la methode post pour envoyer les donne 
    //on entre d'adord l'url et par la suite les donne a envoyer sous forme de cle-valeur notament dans le body
    final response= await http.post(Uri.parse("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/userViewmodel.php"),body: {
      "nom":encrypt(nom),
      "pass":encrypt(pass),
      "action":action,
    });
    //on fait une condition pour voir si la requette as ete executer normalement
    if (response.statusCode==200) {
      //print(decrypt(response.body));
      var data=jsonDecode((response.body));
      
      var result=data['data'];
      print(result);
      int succes=result["success"];
      print(succes);
      if(succes==1){
        setState((){
          _loading=false;
          erreur=result["message"];
          print(result["user"]);
          var user=result["user"];
          UserModel.saveUser(UserModel.fromJson(user));
          //on deporte la fonction login et l'appel ici
          widget.login.call();
        });
      }else{
         setState((){
          print(result["message"]);
          erreur=result["message"];
          _loading=false;
        });

      }
    } else {
        print("Erreur de connexion1 : ${response.statusCode}");
      print("error: ${response.body}");
        
    }
  } catch (error) {
    print("Erreur de connexion2 : $error");
    
  }
}

  //instanciationde l'objet pour faire les inputs
  CustomTextFied nomText=new CustomTextFied(
    title: "nom d'utilisateur",
    placeholder: "entrez votre nom d'utilisateur"
  );
  CustomTextFied passText=new CustomTextFied(
    title: "mot de pass",
    placeholder: "entrez votre mot de pass",
    ispass: true,
    );
  //initialisation de la cle de validation
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nomText.err="entrez votre nom d'utilisateur";
    passText.err="entrez votre mot de pass";
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
          Text('Connexion',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 30,),
          nomText.textfrofield(),
          //Text('PassWord',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 15,),
          passText.textfrofield(),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              if (_key.currentState?.validate() ?? false) {
                
                login(nomText.value, passText.value,"login");
              } else {
                
              }
                //Navigator.push(context, MaterialPageRoute(builder: (context) => PagePincipal()));
                 //print("ok");

            },
            child: Text('se connecter',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
              Text("vous n'avez pas de compte? "),
              TextButton(
              onPressed: widget.toggle,
              child: Text('creer un compte', style: TextStyle(fontSize: 15, color:Colors.blueAccent),),
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
        ],
        ),
            )
        )
      ),)
    );
  }
}