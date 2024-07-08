import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:mywellbeing/models/userModel/postModel.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:mywellbeing/api/api.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
 String _message = '';
  String erreur = "";
  bool _loading = false;
// Fonction pour envoiyer les messages
void sendMessage(String titre, String type, String contenu, String description, String id_utilisateur,)  async {
  setState(() {
      erreur = "";
      _loading = true;
    });
  try {

    final uri = Uri.parse('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/sendMessage.php');
    final request = http.MultipartRequest('POST', uri)
       ..fields['titre'] = titre
      ..fields['type'] = type
      ..fields['contenu'] = contenu
      ..fields['description'] = description
      ..fields['id_utilisateur'] = id_utilisateur;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = response.body;
      //print('Response body: $responseBody'); // Afficher la réponse dans la console
       var data = jsonDecode(response.body);
        var result = data['data'];
        int success = result["success"];
        if (success == 1) {
          setState(() {
            _loading = false;
            erreur = result["message"];
          });
              
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(erreur)),
          );
          //chargement des nouveau messages
          getdata();
        } else {
          setState(() {
            erreur = result["message"];
            _loading = false;
          });
        }
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre message n\'as pas pu etre envoyer')),
      );
    }
  } catch (e) {
    print('Error de l\'enregistrement: $e');
    // Gérer l'erreur ici, par exemple afficher un message d'erreur à l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('erreur: probleme de connection')),
      );
      setState(() {
      _loading = false;
    });
  }
}
// lecture des messagess
 List<PostModel> messageModel = [];
  Future<void> getdata() async {
    setState(() {
      _loading = true;
    });

    try {
      var data = await Api.getMessage();
      if (data != null) {
        messageModel.clear();
        for (Map i in data) {
          setState(() {
            messageModel.add(PostModel.fromJson(i));
             _scrollToBottom();
          });
          
        }
        print("***********888888888888888");
        print(messageModel);
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
UserModel? _user;
int id_utilisateur=0;

  void _loadUser() async {
    UserModel? user = await UserService.infoUser();
    setState(() {
      if(user != null){
        _user = user;
        id_utilisateur=_user!.id_utilisateur;
        
      }
      
    });
  }
  //scroll auto
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
   final ScrollController _scrollController = ScrollController();
   void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

 @override
  void initState() {
    super.initState();
    getdata();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
          leadingWidth: 30,
          title: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/actualite2.jpg"),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10),
                  child: Text(
                    "Bien-etre et sante",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 8, right: 15),
              child: Icon(
                Icons.call,
                color: Colors.white,
                size: 26,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 10),
              child: Icon(
                Icons.video_call,
                color: Colors.white,
                size: 26,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, right: 10),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      body: messageModel == null ?
          Center(child: CircularProgressIndicator())
        : Container(
          padding: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
            controller: _scrollController,
           itemCount: messageModel.length,
           itemBuilder: (context, index) {
             final message = messageModel[index];
             if(message.user != id_utilisateur){
                  return Padding(
                    padding: const EdgeInsets.only(right: 80),
                    child: Column(
                      children: [
                         Row(
                      children: [
                        //profil
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/profils/${message.photo}"),

                        ),
                        //texte a cotee du profil
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          
                          child: Column(
                            children: [
                              Text(
                                message.prenom,
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                              ),
                              Text(
                                message.role,
                                style: TextStyle(fontSize: 14,color: Colors.grey[700]),
                              ),
                              
                            ],
                          ),
                        )
                      ]
                    ),
                    ClipPath(
                    clipper: UpperNipMessageClipper(MessageType.receive),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE1E1E2),
                      ),
                      child:  Column(
                        children: [
                          Text(message.contenue,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text("envoyer le " +message.date_post,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        ],
                      )
                    ),

                    ),
                      ],
                    )
                    
                    );
             }else{
                  return Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,left: 80),
                      child: ClipPath(
                        clipper: LowerNipMessageClipper(MessageType.send),
                        child: Container(
                          padding: const EdgeInsets.only(left: 20,top: 10,bottom: 25,right: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFF7165D6),
                          ),
                          child:  Column(
                        children: [
                          Text(message.contenue,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                          Text("envoyer le " +message.date_post,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white
                          ),
                          textAlign: TextAlign.right,
                        ),
                        ],
                      )
                          //  Text(
                          //   message.contenue,
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ),
                      ),
                      ),
                  );
             }
           }
          ),
    
        ),
      bottomSheet: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
            InkWell(
              onTap: () {
                getdata();
              },
              child: 
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.update,
                color: Colors.amber,
                size: 30,
              ),
            ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Votre message",
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _message = value;
                    });
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () async{
                 if(_message !=''){
                  //recuperation de l'id de l'utilisateur
                  UserModel? user = await UserService.infoUser();
                  var id=user!.id_utilisateur;
                  sendMessage("message", "message", _message, "message", id.toString());
                  //getdata();
                  print("******************messages ok************");
                }else{
                  print("******************messages veillez ecrire un message************");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ecrivez un message!')),
                );
                }
                
              },
              child:  Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.send,
                size: 30,
                color: Color(0xFF7165D6),
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}