import 'package:flutter/material.dart';
import 'package:mywellbeing/screen/actualiteAdd.dart';
class ActualiteList extends StatefulWidget {
  const ActualiteList({super.key, required this.title});
  final String title;

  @override
  State<ActualiteList> createState() => _ActualiteListState();
}

class _ActualiteListState extends State<ActualiteList> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueAccent,
        title: Text(widget.title,
          style: TextStyle(color: Colors.blueAccent,fontSize: 27,),
          textAlign: TextAlign.center,
        ),
      ),
      body:  SingleChildScrollView( 
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),

            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 245, 220,1.0),
            ),
            //la photo de profil , le texte a cotee
            child: Column(
              children: [
                
                Row(
                  children: [
                    //profil
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/images/profile.png"),

                    ),
                    //texte a cotee du profil
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            "Stephane Pro",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                          ),
                          Text(
                            "Coatch de sport",
                            style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                          ),
                          
                        ],
                      ),
                    )
                    

                  ],
                ),
                //texte descriptif de l'actualite
                Container(
                  margin: EdgeInsets.all( 10),
                  child: Text(
                     "Lorsque vous faites du sport, vous brûlez plus de calories qu’au repos. Ainsi, cela peut permettre de perdre du poids ou de prévenir la prise de poids.",
                     style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                   ),
                ),
                //l'image au millieur
               Container(
                  width: 400,
                  height: 200,
                   decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/actualite1.jpeg"),
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
          ),
//second actualite
Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(245, 245, 220,1.0),
            ),
            //la photo de profil , le texte a cotee
            child: Column(
              children: [
                
                Row(
                  children: [
                    //profil
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage("assets/images/profile2.jpg"),
                    ),
                    //texte a cotee du profil
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text(
                            " Horlane ",
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                          ),
                          Text(
                            "Cardiologue",
                            style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                          ),
                          
                        ],
                      ),
                    )
                    

                  ],
                ),
                //texte descriptif de l'actualite
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                     "Être en bonne santé, c’est la condition élémentaire de la tranquillité.",
                     style: TextStyle(fontSize: 15,color: Colors.grey[700]),
                   ),
                ),
                //l'image au millieur
               Container(
                  width: 400,
                  height: 200,
                   decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/actualite2.jpg"),
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
          ),
          // Container(
          //   child: Center(
          //     child: Column(
          //       children: <Widget>[
          //         const Text(
          //           'You have pushed the button this many times:',
          //         ),
          //         Text(
          //           '$_counter',
          //           style: Theme.of(context).textTheme.headlineMedium,
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
      ),
      //code du bouton flotant
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ActualiteAdd()));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.blueAccent, // Définit la couleur du bouton en bleu
        foregroundColor: Colors.white, // Définit la couleur de l'icône en blanc
        child: const Icon((Icons.add_circle),
      ),
      )
    );
  }
}
