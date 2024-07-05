import 'package:flutter/material.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:mywellbeing/views/authantification/login.dart';
import 'package:mywellbeing/views/authantification/register.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/profil.dart';

class HomePage extends StatefulWidget {
 // final VoidCallback login;,required this.login
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = true;
  //variable pour verifier si la connection est effectuer
  bool login=false;
  void toggle() {
    setState(() {
      visible = !visible;
    });
  }

  void navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profil()),
    );
  }
// methode pour modifier l'eta de la variable login
isLogin(){
  setState(() {
    login=!login;
  });
}
//fonction pour verifier si l;utilisateur est bel et bien connecter ou pas
isconnected() async{
await UserModel.getUser();
if(UserModel.sessionUser != null){
  setState(() {
    login=true;
  });
}else{
  setState(() {
    login=false;
  });
}
}
@override
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    isconnected();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "My Well being",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //       fontSize: 30,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.white,
      //     ),
      //   ),
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.blueAccent[400],
      // ),
      body: Column(
        children: [
          Expanded(
            //test si la connection est effectuer pour afficher la page necessaire
            child: login? PagePincipal()
            :visible ? Login(toggle: toggle,login: isLogin) : Register(toggle: toggle),
          ),
         
        ],
      ),
    );
  }
}
