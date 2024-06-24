import 'package:flutter/material.dart';
import 'package:mywellbeing/views/authantification/login.dart';
import 'package:mywellbeing/views/authantification/register.dart';
import 'package:mywellbeing/views/profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visible = true;

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

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: visible ? Login(toggle: toggle) : Register(toggle: toggle),
          ),
         
        ],
      ),
    );
  }
}
