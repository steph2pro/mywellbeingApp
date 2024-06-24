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
              child:
            Text("Vos exercices Physique",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 25),
              textAlign: TextAlign.center,
              ),
            ),

      SizedBox(
        height: 290,
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
                    color: const Color(0xFFF4F6FA),
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
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Commencer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
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