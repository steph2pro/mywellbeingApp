
import 'package:flutter/foundation.dart';

class PostModel{
  String id_post;
  String titre;
  String type;
  String contenue,date_post;
  String user;
  PostModel({required this.id_post,required this.titre,required this.type,required this.contenue,required this.date_post,required this.user});
  // methode pour convertir un json en objet postModel
  // Méthode pour convertir un JSON en objet PostModel
  factory PostModel.fromJson(Map<String, dynamic> j) {
    return PostModel(
      id_post: j["id_message"], 
      user: j["id_utilisateur"],
      titre: j["titre"], 
      type: j["type"], 
      contenue: j["contenu"], 
      date_post: j["date_envoi"]
    );
  }
  Map toMap(){
    return {
      "id_message":id_post,
      "id_utilisateur":user,
      "titre":titre,
      "type":type,
      "contenue":contenue,
    };
  }
}