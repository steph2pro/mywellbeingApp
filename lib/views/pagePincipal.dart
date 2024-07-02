import 'package:flutter/material.dart';
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
  int _currentIndex = 0;

  Future<void> _loadContent() async {
    await Future.delayed(Duration(seconds: 1)); // Simule un délai de chargement
  }

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: [
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "MY WELLBEING",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "Programmes",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "Actualités",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "Mes Discutions",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: const Text(
                    "Mon Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montseraat',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavBarWidget()
              ],
            ),
          ][_currentIndex],
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent[400],
        ),
        body: FutureBuilder<void>(
          future: _loadContent(), // Attends que le contenu soit chargé
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Patientez ... ',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ); // Affiche une animation de chargement
            } else {
              return [
                ContenuePagePincipal(),
                ProgrammeList(),
                ActualiteList(),
                MessagesScreen(),
                MyProfile(),
              ][_currentIndex]; // Affiche le contenu lorsque le chargement est terminé
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          unselectedFontSize: 16,
          selectedFontSize: 17,
          iconSize: 32,
          elevation: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Accueil",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "programme",
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
          ],
        ),
      ),
    );
  }
}
