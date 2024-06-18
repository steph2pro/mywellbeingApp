import 'package:flutter/material.dart';
import 'package:petitparser/parser.dart';

class ExerciceWidget extends StatelessWidget {
  const ExerciceWidget({super.key});
Widget build(BuildContext context) {
  List<String> mesImg = [
    "assets/images/exercice1.gif",
    "assets/images/exercice2.gif",
    "assets/images/exercice3.gif",
    "assets/images/exercice4.gif",
  ];
  return Column(
    children: [
          SizedBox(height: 10),
          Container(
            width: 400,
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(249, 66, 158, 1.0),
              child:
            Text("Vos exercices Physique",
              style: TextStyle(color: Colors.white,fontSize: 30),
              textAlign: TextAlign.center,
              ),
            ),

      SizedBox(
        height: 270,
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
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue,
                    Colors.lightBlue,
                    Colors.green,
                  ],
                ),
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
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Commencer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent.withOpacity(.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
}