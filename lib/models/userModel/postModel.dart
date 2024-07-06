
import 'package:flutter/foundation.dart';

class PostModel{
  int id_post;
  String titre;
  String type,description;
  String contenue,date_post;
  int user;
  PostModel({required this.id_post,required this.titre,required this.type,required this.contenue,required this.description,required this.date_post,required this.user});
  // methode pour convertir un json en objet postModel
  // Méthode pour convertir un JSON en objet PostModel
  factory PostModel.fromJson(Map j) {
    return PostModel(
      id_post: j["id_message"], 
      user: j["id_utilisateur"],
      titre: j["titre"], 
      type: j["type"], 
      contenue: j["contenu"], 
      description: j["description"], 
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
      "description":description,

    };
  }
}