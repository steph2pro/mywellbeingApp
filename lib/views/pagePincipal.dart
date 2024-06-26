
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/Acceuil.dart';
import 'package:mywellbeing/views/actualiteList.dart';
import 'package:mywellbeing/views/myProfile.dart';
import 'package:mywellbeing/views/contenuePagePincipal.dart';
import 'package:mywellbeing/views/programmeList.dart';
import 'package:mywellbeing/views/messages_screen.dart';
import 'package:mywellbeing/views/widgets/navBarWidget.dart';

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
                  child: const Text("MY WELLBEING",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  NavBarWidget()
              ]
            ),
           
            Row(
              children: [
                Expanded(
                  child:  const Text("Programmes",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                 ),
                ),
                  NavBarWidget()
                   
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("Actualités",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  NavBarWidget()
                 
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("Mes Discutions",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                  NavBarWidget()
                   
              ]
            ),
            
            Row(
              children: [
                Expanded(
                  child: 
                  const Text("Mon Profile",
                    style:TextStyle(color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ]
            ),
           
          ][_currentIndex],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent[400],
           
        ),
        body: [
          ContenuePagePincipal(),
          ProgrammeList(),
          ActualiteList(),
          //ActualiteList(title: "vos actualités"),
          MessagesScreen(),
          MyProfile(),
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
                label: "Moi",
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
    // Widget   = Container(
    //   child: Row(
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           // Action à effectuer lorsque tu cliques sur l'image
    //           // // Navigue vers une autre page
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => AutrePage()),
    //           // );
    //         },
    //         child: CircleAvatar(
    //           backgroundImage: AssetImage('assets/images/profile.png'),
    //           radius: 20,
    //         ),
    //       ),
    //       SizedBox(width: 10),
    //       GestureDetector(
    //         onTap: () {
    //           // Action à effectuer lorsque tu cliques sur l'icône de recherche
    //           // // Navigue vers une autre page
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(builder: (context) => AutrePage()),
    //           // );
    //         },
    //         child: IconButton(
    //           icon: Icon(Icons.search),
    //           onPressed: () {
    //             // Action à effectuer lors du clic sur l'icône de recherche
    //           },
    //         ),
    //       ),
    //       GestureDetector(
    //         onTap: () {
    //           // Action à effectuer lorsque tu cliques sur l'icône de notification
    //           // Navigue vers une autre page
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => NotificationList()),
    //           );
    //         },
    //         child: IconButton(
    //           icon: Icon(Icons.notifications),
    //           onPressed: () {
    //             // Action à effectuer lors du clic sur l'icône de notification
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
}