
import 'package:flutter/material.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/professionelModel.dart';
import 'package:mywellbeing/views/appointmentScreen.dart';
import 'package:mywellbeing/views/widgets/loading.dart';

class SpecialisteList extends StatefulWidget {
   const SpecialisteList({super.key});
  

  @override
  State<SpecialisteList> createState() => _SpecialisteListState();
}

class _SpecialisteListState extends State<SpecialisteList> {
  
 
   List<ProfessionelSante> professionnels= [];
  String erreur = "";
  bool _loading = false;

  Future<void> getdata() async {
    setState(() {
      _loading = true;
    });

    try {
      var data = await Api.getProfessionel();
      if (data != null) {
        professionnels.clear();
        for (Map i in data) {
          setState(() {
            professionnels.add(ProfessionelSante.fromJson(i));
          });
          
        }
        print("***********888888888888888");
        print(professionnels);
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
    return  SingleChildScrollView(
    padding: const EdgeInsets.only(top:40),
    child: _loading ? Loading()
    :Column(
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
                  itemCount: professionnels.length,
                  itemBuilder: (context , index){
                    final professionel=professionnels[index];
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
                      child: Text(professionel.specialite,
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
                  childAspectRatio: 0.85, 
                  
                  ),
                  itemCount: professionnels.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    final professionel=professionnels[index];
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
                            
                          backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${professionel.photo}"),
                          ),
                          professionel.sexe == "Masculin" ?
                           Text(
                            "Mr. "+professionel.prenom ,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          )
                          : Text(
                            "Mme. "+professionel.prenom ,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20), // Ajoute un padding de 16 pixels de tous les côtés
                            
                            child:  Text(
                            professionel.specialite,
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

 
