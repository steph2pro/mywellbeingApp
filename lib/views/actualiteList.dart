import 'package:flutter/material.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/postModel.dart';
import 'package:mywellbeing/views/actualiteAdd.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:mywellbeing/views/widgets/loading.dart';

// Modèle de données pour représenter un Actualite
class Actualite {
  final String profil;
  final String name;
  final String role;
  final String description;
  final String imageUrl;

  Actualite({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.profil,
    required this.role,
  });
}

class ActualiteList extends StatefulWidget {
  @override
  State<ActualiteList> createState() => _ActualiteListState();
}

class _ActualiteListState extends State<ActualiteList> {
  List<PostModel> postModel = [];
  String erreur = "";
  bool _loading = false;

  Future<void> getdata() async {
    setState(() {
      _loading = true;
    });

    try {
      var data = await Api.getPost();
      if (data != null) {
        postModel.clear();
        for (Map i in data) {
          setState(() {
            postModel.add(PostModel.fromJson(i));
          });
          
        }
        print("***********888888888888888");
        print(postModel);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des actualites'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : postModel.isEmpty
              ? Center(child: Text("Aucune actualité trouvée"))
              : SingleChildScrollView(
                  child: Expanded(
                    child: Column(                    
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 170,
                        padding: EdgeInsets.only(bottom: 50),
                        child: ListView.builder(
                          itemCount: postModel.length,
                          itemBuilder: (context, index) {
                            final post = postModel[index];
                            if(post.type == "ActualiteIMG"){
                                  return Container(
                                    margin: EdgeInsets.all(10),

                                    padding: EdgeInsets.all(10),
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
                                      
                                    children: [
                                    Row(
                                        children: [
                                          //profil
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${post.photo}"),

                                          ),
                                          //texte a cotee du profil
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            
                                            child: Column(
                                              children: [
                                                Text(
                                                  post.prenom,
                                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                                                ),
                                                Text(
                                                  post.role,
                                                  style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                                                ),
                                                
                                              ],
                                            ),
                                          )
                                        ]
                                      ),



                                      Text(post.titre,
                                      style: TextStyle(fontSize: 20,color: Colors.grey[900],fontWeight: FontWeight.w500)
                                      ,textAlign: TextAlign.center,
                                      ),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Container(
                                        margin: EdgeInsets.all( 10),
                                        child: Text(
                                          post.description,
                                          style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                                        ),
                                      ),
                                      //l'image au millieur
                                    Container(
                                        width: 400,
                                        height: 250,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/actualites/${post.contenue}') as ImageProvider<Object>,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                      ),
                                      //les icones et le texte en bas
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical au centre
                                          crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal au centre
                                          mainAxisSize: MainAxisSize.min, // Réduit la taille de la colonne à son contenu
                                          
                                          children: [
                                            Text("Publier le : "+post.date_post,textAlign: TextAlign.right,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement équitable entre les icônes et le texte
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(Icons.thumb_up, color: Colors.green),
                                                    Text("Liker", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.comment, color: Colors.green),
                                                    Text("Commenter", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.share, color: Colors.green),
                                                    Text("Partager", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )





                                    ],
                                  ),
                                  );
                              // return ListTile(
                              //   title: Text(
                              //     post.titre,
                              //     style: TextStyle(color: Colors.red),
                              //   ),
                              // );
                            }else{
                              return Container(
                                    margin: EdgeInsets.all(10),

                                    padding: EdgeInsets.all(10),
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
                                    children: [
                                    Row(
                                        children: [
                                          //profil
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${post.photo}"),

                                          ),
                                          //texte a cotee du profil
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            
                                            child: Column(
                                              children: [
                                                Text(
                                                  post.prenom,
                                                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                                                ),
                                                Text(
                                                  post.role,
                                                  style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                                                ),
                                                
                                              ],
                                            ),
                                          )
                                        ]
                                      ),




                                      Text(post.titre,
                                      style: TextStyle(fontSize: 20,color: Colors.grey[900],fontWeight: FontWeight.w500)
                                      ,textAlign: TextAlign.center,
                                      ),
                                      Padding(padding: EdgeInsets.all(10)),
                                      Container(
                                        margin: EdgeInsets.all( 10),
                                        child: Text(
                                          post.description,
                                          style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                                        ),
                                      ),
                                      //contenue textuel
                                      Padding(padding: EdgeInsets.all(10)),
                                      Container(
                                        margin: EdgeInsets.all( 10),
                                        child: Text(
                                          post.contenue,
                                          style: TextStyle(fontSize: 17,color: Colors.grey[800]),
                                        ),
                                      ),
                                      Padding(padding: EdgeInsets.all(10)),
                                      //les icones et le texte en bas
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center, // Alignement vertical au centre
                                          crossAxisAlignment: CrossAxisAlignment.center, // Alignement horizontal au centre
                                          mainAxisSize: MainAxisSize.min, // Réduit la taille de la colonne à son contenu
                                          
                                          children: [
                                            Text("Publier le : "+post.date_post,textAlign: TextAlign.right,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacement équitable entre les icônes et le texte
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(Icons.thumb_up, color: Colors.green),
                                                    Text("Liker", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.comment, color: Colors.green),
                                                    Text("Commenter", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(Icons.share, color: Colors.green),
                                                    Text("Partager", style: TextStyle(color: Colors.green)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )





                                    ],
                                  ),
                                  );

                            }
                          },
                          
                        ),
                      ),
                    ],
                  ),
                    ),
                ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                getdata();
              },
              tooltip: 'Mettre à jour',
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              child: const Icon(Icons.update, size: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ActualiteAdd()));
                },
                tooltip: 'Ajouter',
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                child: const Icon(Icons.add_circle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
