import 'package:flutter/material.dart';
import 'package:mywellbeing/views/Acceuil.dart';
import 'package:mywellbeing/views/pagePincipal.dart';
import 'package:mywellbeing/views/chargement.dart';
import 'package:mywellbeing/views/recaptch.dart';

void main() {
  runApp(  
  MyApp()
  );
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
       home :Acceuil(),
       
    );
  }
}

