// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/professionel.dart';
import 'package:mywellbeing/views/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mywellbeing/models/profilModel/profilModel.dart';
import 'package:mywellbeing/views/authantification/saveprofil.dart';
import 'package:mywellbeing/views/programmeList.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:mywellbeing/models/profilModel/profilModel.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/professionelModel.dart';

import 'package:mywellbeing/views/homePage.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Modèle de données pour représenter un programme
class Program {
  final String name;
  final String imageUrl;
  final String description;

  Program({
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // Liste des images
  List<String> mesImg = [
    "assets/images/exercice1.gif",
    "assets/images/exercice2.gif",
    "assets/images/exercice3.gif",
    "assets/images/exercice4.gif",
  ];
  
  List<String> imgs = ['doctor1.jpg', 'doctor2.jpg', 'doctor3.jpg', 'doctor4.jpg'];
  
  final List<Program> programs = [
    Program(
      name: "Programme de régime",
      imageUrl: "assets/images/regime.jpg", // URL en tant que ressource locale
      description: "Perdre jusqu'à 7kg en 1 mois",
    ),
    Program(
      name: "Programme sportif",
      imageUrl: "assets/images/sport.jpg", // URL en tant que ressource locale
      description: "Bougez et maintenez-vous en forme",
    ),
    Program(
      name: "Programme de régime",
      imageUrl: "assets/images/regime.jpg", // URL en tant que ressource locale
      description: "Perdre jusqu'à 7kg en 1 mois",
    ),
    Program(
      name: "Programme sportif",
      imageUrl: "assets/images/sport.jpg", // URL en tant que ressource locale
      description: "Bougez et maintenez-vous en forme",
    ),
  ];

  UserModel? _user;
  Profile? _profil;
  ProfessionelSante? _prof; 
  @override
  void initState() {
    super.initState();
    
    print("load user^^^^^^^^^^^^^^^^^^");
    _loadUser();
    print("get data^^^^^^^^^^^^^^^^^^");
    getdata();
    _loadProfil();
    //_loadProfessionel();
    
  }

  void _loadUser() async {
    UserModel? user = await UserService.infoUser();
    setState(() {
       _user = user;
      if(_user !=null){
       
        //id =_user!.id_utilisateur;
      }
    });
    
    
  }
   void _loadProfil() async {
    Profile? profil = await ProfilService.infoProfil();
    setState(() {
      _profil = profil;
    });
    //print(_profil!.age);
    
    
  }
  //  void _loadProfessionel() async {
  //   ProfessionelSante? prof = await ProfessionelService.infoProfessionel();
  //   setState(() {
  //     _prof = prof;
  //     print("8888888    contenue     88888888888");
  //     print(_prof);
  //     print(_prof!.description);
  //   });
  // } 
  List<ProfessionelSante> prof= [];
  
  String erreur = "";
  bool _loading = false;

  Future<void> getdata() async {
    setState(() {
      _loading = true;
    });

    try {
      UserModel? user = await UserService.infoUser();
       if(_user !=null){
        var id_user=user!.id_utilisateur;
      print("*************************************************"+id_user.toString());
       //var id_user=user!.id_utilisateur;
      var data2= await Api.getProfUser(id_user.toString());
      if ( data2 != null) {
        print("*********iddddddddddddddddddddddddd prrof");
       print(prof);
        prof.clear();
        for (Map i in data2) {
          setState(() {
            prof.add(ProfessionelSante.fromJson(i));
          });
          
        }
        }
        print("*********iddddddddddddddddddddddddd prrof");
    
        
        print(prof);
        setState(() {
        _loading = false;
      });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        erreur = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }


 
 
  @override
  Widget build(BuildContext context) {
    return _user ==null ?
        Scaffold(
          body: Loading(),
        )
        :Scaffold(
      backgroundColor: const Color(0xFF7165D6),
       body:
      
             SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => PagePincipal()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                UserModel.logOut();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              },
                              child: const Icon(
                                Icons.logout_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ), 
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: (_user != null)
                                  ? NetworkImage('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${_user!.photo}') as ImageProvider<Object>
                                    :AssetImage('assets/images/profile.png'),
                              ),
                              const SizedBox(height: 15),
                              _user != null
                                  ? Text(
                                      "${_user!.prenom} ${_user!.nom}",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(height: 5),
                              Text(
                                "${_user!.role}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9F97E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.help,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9F97E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9F97E2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SaveProfil()),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.edit_square,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height / 0.9*1.5,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      _profil != null ?
                        Column(
                          children: [
                            const Text(
                          "Informations du profil utilisisateur",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        
                            
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                          title: _profil !=null ?
                          Text(_profil!.villeResidence,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),)
                          :Container(),
                          //const Text(
                          //   "BAFOUSSAM, Quartier AWoussa"
                          // ),
                          subtitle: const Text("Adresse de résidence"),
                        ),ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.spa,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                          title: const Text(
                            "age, taille, poids",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: _profil !=null ?
                          Text(_profil!.age +' Ans ,'+_profil!.taille+' M, '+_profil!.poids + ' Kgs ')
                          :Container(),
                        ),ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.directions_run,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                          title: const Text(
                            "Objectif",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: _profil !=null ?
                          Text(_profil!.objectif)
                          :Container(),
                        )
                          ],
                        )
                      : Container(),
                      // proffesionnel
                      (_loading==true) ? Loading()
                        
                      : Container(
                        child: 
                          prof.isNotEmpty ?
                        Column(
                          children: [
                            const Text(
                          "Informations du profil de Professionel de sante",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ListTile(
                          leading: 
                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${prof[0].photo}"),

                                          ),
                          title:  Text(
                            prof[0].specialite,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: 
                          Text(prof[0].description),
                        ),
                          ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.speaker_sharp,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                          title: const Text(
                            "Disponibile",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: 
                          Text(prof[0].disponibilite),
                        ),ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF0EEFA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.hourglass_bottom_sharp,
                              color: Color(0xFF7165D6),
                            ),
                          ),
                          title: const Text(
                            "horaire de travail",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: 
                          Text(prof[0].horaire),
                        ),
                          ],
                        )
                        :Container(),
                      ),



                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Programme alimentaire suivi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.star, color: Colors.amber),
                            const Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          width: 600,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: programs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 150,
                                width: 300,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.4,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: Image.asset(programs[index].imageUrl).image,
                                        ),
                                        title: Text(
                                          programs[index].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: const Text("Il y a un jour"),
                                        trailing: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              "3.9",
                                              style: TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          programs[index].description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Text(
                              "Programme Sportif suivi",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.star, color: Colors.amber),
                            const Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: mesImg.length,
                            itemBuilder: (context, index) {
                              String monImg = mesImg[index];
                              return Container(
                                width: 200,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: AssetImage(monImg),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        
                        
                        Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      Container(
                        child: Text("Rejoignez Notre Réseau de Spécialistes de la Santé ! Vous êtes un professionnel de la santé et souhaitez offrir vos services via notre application ? Nous serions ravis de vous accueillir dans notre communauté dédiée à l'amélioration du bien-être.Contactez-nous dès aujourd'hui et découvrez comment nous pouvons collaborer pour offrir une expérience de santé exceptionnelle à nos utilisateurs.Cliquez sur le bouton ci-dessous pour nous envoyer un message sur WhatsApp et commencer cette aventure avec nous !",
                            style: TextStyle(fontSize: 15, color:Colors.grey[800]),  
                          ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          final String message = 'Bonjour, j\'aimerais discuter avec vous. dans le but d\'avoir un grade de specialiste de sante dans votre application My Wellbeing '; // Message par défaut
                          final Uri whatsapp= Uri.parse("https://wa.me/+237671506217?text=${Uri.encodeFull(message)}");
                          //final String whatsappUrl = 'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';
                           //String url = 'https://wa.me/$phoneNumber';
                          // if (await canLaunch(url)) {
                          //   await launch(url);
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('Impossible d\'ouvrir WhatsApp.'),
                          //     ),
                          //   );
                          // }
                          try {
                          // if (await canLaunch(url)) {
                          //   await launch(url);
                          // } else {
                          //   throw 'Could not launch $url';
                          // }
                          launchUrl(whatsapp);
                        } catch (e) {
                          print('Error launching WhatsApp: $e');
                        }
                        },
                        icon: Icon(Icons.message_rounded, color: Colors.green),
                        label: Text(
                          'Contactez-nous via WhatsApp',
                          style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                        ),
                      ),
                      
                    ],
                   ),
                      ],
                    ),
                  ),
                  
                ]
              ),
            ) ,
            floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SaveProfil()));
              },
            tooltip: 'creer un profil utilisateur',
            backgroundColor: Colors.blueAccent, // Définit la couleur du bouton en bleu
            foregroundColor: Colors.white, // Définit la couleur de l'icône en blanc
            child: const Icon(Icons.add_reaction_sharp),
            ),
          ),
          _user !=null?
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: _user!.role !="simple_utilisateur"?
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Professionel()));
                },
                tooltip: 'creer un profil pro',
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add_circle_outline_sharp, size: 30),
              )
              :Container(),
            ),
          )
          :Container(),
        ],
      ),


  
    );


      }
}
