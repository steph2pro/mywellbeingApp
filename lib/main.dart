import 'package:flutter/material.dart';
import 'package:mywellbeing/Acceuil.dart';
import 'package:mywellbeing/pagePincipal.dart';
import 'package:mywellbeing/screen/homePage.dart';
import 'package:mywellbeing/screen/test/scrollWidget.dart';

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
       home :PagePincipal(),
    );
  }
}

