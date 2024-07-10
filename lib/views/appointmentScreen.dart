// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/professionelModel.dart';
import 'package:mywellbeing/views/widgets/loading.dart';

class AppointmentScreen extends StatefulWidget {
   final int idProf;
    AppointmentScreen({super.key,required this.idProf});
  // var id=thisidPof

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
 late int id;
// ignore: use_key_in_widget_constructors
//class AppointmentScreen extends StatelessWidget{
   List<String> imgs = ['doctor1.jpg', 'doctor2.jpg', 'doctor3.jpg', 'doctor4.jpg'];
   
   List<ProfessionelSante> professionnels= [];
   List<ProfessionelSante> prof= [];

  String erreur = "";
  bool _loading = false;

  Future<void> getdata() async {
    setState(() {
      _loading = true;
    });

    try {
      id = widget.idProf;
      var data = await Api.getProfessionel();
      var data2= await Api.getProf(id.toString());
      if (data != null && data2 != null) {
        professionnels.clear();
        for (Map i in data) {
          setState(() {
            professionnels.add(ProfessionelSante.fromJson(i));
          });
          
        }
        prof.clear();
        for (Map i in data2) {
          setState(() {
            prof.add(ProfessionelSante.fromJson(i));
          });
          
        }
        print("***********888888888888888");
        print(professionnels);
        print("*********iddddddddddddddddddddddddd");
    
        
        print(prof);
        setState(() {
        _loading = false;
      });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        erreur = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

@override
   Widget build(BuildContext context){
    return   Scaffold(
      backgroundColor: const Color(0xFF7165D6),
      body: _loading ? Loading()
      :SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                 ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       CircleAvatar(radius: 35,
                      backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${prof[0].photo}"),
                      ),
                      const SizedBox(height: 15),
                      //  Text(
                      //   prof[0].nom,
                      //   style: TextStyle(
                      //     fontSize: 23,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      prof[0].sexe == "Masculin" ?
                           Text(
                            "Mr. "+prof[0].prenom +" "+prof[0].nom,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            "Mme. "+prof[0].prenom +" "+prof[0].nom,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                      const SizedBox(height: 5),
                       Text(
                        prof[0].specialite ,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9F97E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF9F97E2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.chat_bubble_text_fill,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                left: 15,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                   Text(
                    prof[0].description ,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Revue",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.star , color: Colors.amber),
                      const Text(
                        "4.9",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.star , color: Colors.amber),
                      const Text(
                        "124",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF7165D6),
                        ),
                      ),
                      const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Text("voir plus"),
                        ),
                    ],
                  ),
                   SizedBox(
                    height: 200,
                    width: 600,
                    child: 
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: professionnels.length,
                      itemBuilder: (context,index){
                        final professionel=professionnels[index];
                        return Container(
                          height: 150,
                           width: 300,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(vertical:5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                             boxShadow:const [
                              BoxShadow(
                              color:Colors.black12,
                              blurRadius:4,
                              spreadRadius: 2,
                            ),
                             ],
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width /1.4,
                            child:  Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                   backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${professionel.photo}"),
                                  ),
                                  title:  professionel.sexe == "Masculin" ?
                           Text(
                            "Mr. "+professionel.prenom +" "+professionel.nom,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                          : Text(
                            "Mme. "+professionel.prenom +" "+professionel.nom,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                                  subtitle:  Text(professionel.specialite),
                                  trailing: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "3.9",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                    ),
                                ),

                                const SizedBox(height: 5),
                                 Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    professionel.description ,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // const Text(
                  //   "Localisation",
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Container(
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: const BoxDecoration(
                  //       color: Color(0xFFF0EEFA),
                  //       shape: BoxShape.circle,
                  //       ),
                  //       child:const Icon(
                  //         Icons.location_on,
                  //         color: Color(0xFF7165D6),
                  //       )
                  //   ),
                  //   title: const Text(
                  //     "BAFOUSSAM, Hopital regional",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: const Text("adresse du lieu de travail"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
   }
}