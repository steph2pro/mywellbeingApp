// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:mywellbeing/views/chat_screen.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/professionelModel.dart';
import 'package:mywellbeing/views/widgets/loading.dart';

class MessagesScreen extends StatefulWidget {
   const MessagesScreen({super.key});
  

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  


// class MessagesScreen extends StatelessWidget {
//   MessagesScreen({super.key});
  List<String> imgs = ['doctor1.jpeg', 'doctor2.jpeg', 'doctor3.jpeg', 'doctor4.jpeg'];
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Discution",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Recherche",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.search,
                    color: Color(0xFF7165D6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30), // Ajouter de l'espace
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              " Professionel En ligne",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10), // Ajouter de l'espace
          _loading ? Loading()
          :SizedBox(
            height: 80, // Augmenter la hauteur
            child: 
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: professionnels.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final prof=professionnels[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Stack(
                    textDirection: TextDirection.rtl,
                    children: [
                      Center(
                        child: SizedBox(
                          height: 65,
                          width: 65,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: 
                            Image.network("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${prof.photo}"),
                            // Image.asset(
                            //   'assets/images/${imgs[index % imgs.length]}',
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(3),
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30), // Ajouter de l'espace
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Forum de discution",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10), // Ajouter de l'espace
          Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>  ChatScreen(),
                    //   ),
                    // );
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: Image.asset("assets/images/actualite2.jpg").image,
                  ),
                  title: const Text(
                    "Bien-etre et sante",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: const Text(
                    "les message en voyee sont lister ici",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: const Text(
                    "14:30",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
              )




          // ListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: 6,
          //   shrinkWrap: true,
          //   itemBuilder: (context, index) {
          //     return Padding(
          //       padding: const EdgeInsets.only(bottom: 10),
          //       child: ListTile(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => const ChatScreen(),
          //             ),
          //           );
          //         },
          //         leading: CircleAvatar(
          //           radius: 30,
          //           backgroundImage: Image.asset("assets/images/${imgs[index % imgs.length]}").image,
          //         ),
          //         title: const Text(
          //           "M. JOhN",
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         subtitle: const Text(
          //           "Bonjour docteur",
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //           style: TextStyle(
          //             fontSize: 16,
          //             color: Colors.black54,
          //           ),
          //         ),
          //         trailing: const Text(
          //           "12:30",
          //           style: TextStyle(
          //             fontSize: 15,
          //             color: Colors.black54,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}