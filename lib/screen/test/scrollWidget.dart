import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Scrollwidget extends StatelessWidget {
   const Scrollwidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return Padding(
              padding:  EdgeInsets.all(8),
              child:  CircleAvatar(
                backgroundColor: Color.fromARGB(255, 71, 170, 219),
              ),
              );
          },
          )
        ),
        SizedBox(
          height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            Image.asset("assets/images/logo.png"),
            Padding(
              padding:  EdgeInsets.all(8),
              child:  CircleAvatar(
                backgroundColor: Color.fromARGB(255, 71, 170, 219),
              ),
              ),
               Padding(
              padding:  EdgeInsets.all(8),
              child:  Image.asset("assets/images/logo.png")
              ),
               Padding(
              padding:  EdgeInsets.all(8),
              child:  CircleAvatar(
                backgroundColor: Color.fromARGB(255, 93, 71, 219),
              ),
              ),
              Container(color: Colors.red,),
              Container(color: Colors.yellow,),
              Container(color: Colors.pink,)
          ],
          )
        ),
        Expanded(
          child:ListView.builder(
          //scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return Padding(
              padding:  EdgeInsets.all(8),
              child: Container(
                height: 150,
                color: Colors.green,
              )
              );
          },
          ) 
          )
        ]
      
      
    );
  }
}
