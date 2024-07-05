import 'package:flutter/material.dart';
import 'package:mywellbeing/views/widgets/MeditationText.dart';
import 'package:mywellbeing/views/widgets/SprortText.dart';
import 'package:mywellbeing/views/widgets/AlimentationText.dart';
import 'package:mywellbeing/views/widgets/HydratationText.dart';

class ProgrameWidget extends StatelessWidget {
  List<String> imgs = [
    'assets/images/image1.jpeg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
    'assets/images/image4.png'
  ];
  List<String> typeProgramme = ['Meditation', 'Sportif', 'Alimentation', 'hydratation'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Programmes les plus suivies",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.70, // Adjust this ratio to avoid overflow
              mainAxisSpacing: 2,
              crossAxisSpacing: 1,
            ),
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MeditationText()),
                      );
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SportText()),
                      );
                      break;
                    case 2:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AlimentationText()),
                      );
                      break;
                    case 3:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HydratationText()),
                      );
                      break;
                    default:
                      break;
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        imgs[index],
                        height: 180,
                        width: 400,
                      ),
                      SizedBox(height: 10),
                      Text(
                        typeProgramme[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}