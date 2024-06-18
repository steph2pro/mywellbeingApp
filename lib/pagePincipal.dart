
import 'package:flutter/material.dart';
import 'package:mywellbeing/Acceuil.dart';
import 'package:mywellbeing/actualiteList.dart';
import 'package:mywellbeing/screen/contenuePagePincipal.dart';
import 'package:mywellbeing/screen/homePage.dart';

class PagePincipal extends StatefulWidget {
  const PagePincipal({super.key});

  @override
  State<PagePincipal> createState() => _PagePincipalState();
}
class _PagePincipalState extends State<PagePincipal> {
  //methode pour changer de page
  int _currentIndex=0;
  setCurrentIndex(int index){
    setState((){
      _currentIndex=index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:[
            Row(
              children: [
                Expanded(
                  child: const Text("MY WELL BEING",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  profilPlus
              ]
            ),
           
            Row(
              children: [
                Expanded(
                  child:  const Text("Liste des Programme",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                ),
                  profilPlus
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("MY WELLBEING",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                profilPlus
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("Liste des ...",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  profilPlus
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("profile",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                profilPlus
              ]
            ),
          ][_currentIndex],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent[400],
           
        ),
        body: [
          ContenuePagePincipal(),
          HomePage(),
          ActualiteList(title: "vos actualités"),
          // EventPage(),
          // AddEventPage(),
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex:_currentIndex,
            onTap:(index)=>setCurrentIndex(index),
            type: BottomNavigationBarType.fixed,
            selectedItemColor:Colors.blueAccent,
            unselectedItemColor:Colors.grey,
            unselectedFontSize: 16,
            selectedFontSize: 17,
            iconSize:32,
            elevation:12,
            items:const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label:"Accueil"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label:"progamme"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article),
                label: "Actualités",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: "Discussion",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profil",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.settings),
              //   label: "Paramètres",
              // ),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.search),
              //     label:"Recherche"
              // )
            ]
        ),


      ),
    );
  }
    Widget profilPlus = Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            radius: 20,
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de recherche
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Action à effectuer lors du clic sur l'icône de notification
            },
          ),
        ],
      ),
    );
}