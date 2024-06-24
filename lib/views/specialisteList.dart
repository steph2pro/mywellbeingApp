
import 'package:flutter/material.dart';
import 'package:mywellbeing/views/appointmentScreen.dart';

// ignore: must_be_immutable
class SpecialisteList extends StatelessWidget {
   SpecialisteList({super.key});
  List<String> symptoms = ['Nutrition','kine','bien-etre'];
   
  List<String> imgs = ['doctor1.jpg', 'doctor2.jpg', 'doctor3.jpg','doctor4.jpg'];
 
 @override
   Widget build(BuildContext context){
    return  SingleChildScrollView(
    padding: const EdgeInsets.only(top:40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            const SizedBox(
              height:25 ,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Nous vous presentons des specialistes en:",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                ),
                SizedBox(height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: symptoms.length,
                  itemBuilder: (context , index){
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                    child: Center(
                      child: Text(symptoms[index],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      )
                      ),
                    )
                  );
            
           },
           ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Quelque professionnels de sante",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              ),
              GridView.builder(
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:2,
                  childAspectRatio: 0.75, 
                  
                  ),
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                   return  InkWell(
                   onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context) => AppointmentScreen(), 
                      ));
                   },
   
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all( 15),
                      
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
                      child:  Column(
                        
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 35,
                            
                          backgroundImage: Image.asset("assets/images/${imgs[index]}").image,
                          ),
                          const Text(
                            "MR ASSAN",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20), // Ajoute un padding de 16 pixels de tous les côtés
                            
                            child: const Text(
                            "Therapist",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          )
                          ,
                          
                          Container(
                            child: const Row(
                            
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                "4,9",
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          )

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

 
