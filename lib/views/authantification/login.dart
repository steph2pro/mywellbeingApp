import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';

class Login extends StatefulWidget {
  //const Login({super.key});
  //fonction visible pour basculer de la page Register a la page register
 final VoidCallback toggle;

  Login({required this.toggle});

  // final Function visible;
  // Login(this.visible);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //instanciationde l'objet pour faire les inputs
  CustomTextFied emailText=new CustomTextFied(
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
    emailText.err="entrez votre nom d'utilisateur";
    passText.err="entrez votre mot de pass";
    return Scaffold(
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
          emailText.textfrofield(),
          //Text('PassWord',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blueAccent[400]),),
          SizedBox(height: 15,),
          passText.textfrofield(),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              // if (_key.currentState?.validate() ?? false) {
              //   print(emailText.value);
              //   print("ok");
              // } else {
                
              // }
                Navigator.push(context, MaterialPageRoute(builder: (context) => PagePincipal()));

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
          )
        ],),
            )
        )
      ),)
    );
  }
}