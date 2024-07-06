import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../myProfile.dart';
import '../notification.dart';
//import '../NavBarWidget.dart';
import '../recherche.dart';
import '../../models/userModel/userModel.dart';// Assurez-vous d'importer votre modèle de profil correctement
class NavBarWidget extends StatefulWidget {
  @override
  _NavBarWidgetState createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
// class NavBarWidget extends StatelessWidget {
//   const NavBarWidget({Key? key});

  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
    
  }

  void _loadUser() async {
    UserModel? user = await UserService.infoUser();
    setState(() {
      _user = user;
    });
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      child: Row(
        children: [
          GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfile()),
                  );
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: _user != null
                                  ? NetworkImage('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${_user!.photo}') as ImageProvider<Object>
                                    :AssetImage('assets/images/profile.png'),
                ),
              ),
          // FutureBuilder<Profile?>(
          //   future: Profile.getProfile(), // Future pour récupérer le profil depuis SharedPreferences
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircleAvatar(
          //         radius: 20,
          //         backgroundImage: AssetImage('assets/images/profile.png'), // Image de chargement par défaut
          //       );
          //     }

          //     if (snapshot.hasError || snapshot.data == null) {
          //       return CircleAvatar(
          //         radius: 20,
          //         backgroundImage: AssetImage('assets/images/profile.png'), // Image par défaut en cas d'erreur ou si le profil est vide
          //       );
          //     }

          //     Profile profile = snapshot.data!;
          //     return GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => NavBarWidget()),
          //         );
          //       },
          //       child: CircleAvatar(
          //         radius: 20,
          //         backgroundImage: profile.photo.isNotEmpty
          //             ? NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${profile.photo}") as ImageProvider<Object>
          //             : AssetImage('assets/images/profile.png'),
          //       ),
          //     );
          //   },
          // ),
          SizedBox(width: 7),
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Recherche()),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationList()),
              );
            },
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationList()),
                    );
                  },
                ),
                Positioned(
                  right: 5,
                  top: 18,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: Text(
                      "5",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
