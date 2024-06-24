import 'package:flutter/material.dart';
import 'package:mywellbeing/views/actualiteAdd.dart';
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
class ActualiteList extends StatelessWidget {
  final List<Actualite> Actualites = [
    Actualite(
      profil: "assets/images/profile.png",
      name: "Steph Pro",
      role: " coach de sport",
      imageUrl: "assets/images/actualite1.jpeg", // URL en tant que ressource locale
      description: "Lorsque vous faites du sport, vous brûlez plus de calories qu’au repos. Ainsi, cela peut permettre de perdre du poids ou de prévenir la prise de poids.",
    ),
    Actualite(
      profil: "assets/images/profile2.jpg",
      name: "Horlane",
      role: "PEdiatre",
      imageUrl: "assets/images/actualite2.jpg", // URL en tant que ressource locale
      description: "Être en bonne santé, c’est la condition élémentaire de la tranquillité.",
    ),
    // Ajoutez d'autres Actualitemes ici
  ];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des actualites'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          
          Expanded(
            child: ListView.builder(
              itemCount: Actualites.length,
              itemBuilder: (context, index) {
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
            //la photo de profil , le texte a cotee
            child: Column(
              children: [
                
                Row(
                  children: [
                    //profil
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(Actualites[index].profil),

                    ),
                    //texte a cotee du profil
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      
                      child: Column(
                        children: [
                          Text(
                            Actualites[index].name,
                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.grey[700]),
                          ),
                          Text(
                            Actualites[index].role,
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
                     Actualites[index].description,
                     style: TextStyle(fontSize: 17,color: Colors.grey[700]),
                   ),
                ),
                //l'image au millieur
               Container(
                  width: 400,
                  height: 200,
                   decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Actualites[index].imageUrl),
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
          );
              },
            ),
          ),
        ],
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