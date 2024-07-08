import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfessionelSante {
  final int id_prof;
  final int id_user;
  final String description;
  final String specialite;
  final String horaire;
  final String disponibilite,nom,prenom,sexe;
  final String photo;

  ProfessionelSante({
    required this.id_prof,
    required this.id_user,
    required this.description,
    required this.specialite,
    required this.horaire,
    required this.disponibilite,
    required this.photo,
    required this.nom,
    required this.prenom,
    required this.sexe,
  });

  factory ProfessionelSante.fromJson(json) {
    return ProfessionelSante(
      id_prof: json['id_professionnel_de_sante'],
      id_user: json['id_utilisateur'],
      description: json['description'],
      specialite: json['specialite'],
      horaire: json['horaire_travail'],
      disponibilite: json['disponibilite'],
      photo: json['photo'],
      nom: json['nom'],
      prenom: json['prenom'],
      sexe: json['sexe'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id_professionnel_de_sante": id_prof,
        "id_utilisateur": id_user,
        "description": description,
        "specialite":specialite,
        "horaire_travail": horaire,
        "disponibilite": disponibilite,
        "photo": photo,
        "nom": nom,
        "prenom": prenom,
        "sexe": sexe,
      };

  static late ProfessionelSante? sessionProfessionel;

  static Future<void> saveProf(ProfessionelSante professionel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = json.encode(professionel.toMap());
    pref.setString("professionel", data);
    pref.commit();
    print("compte de professionel enregistrer avce succes");
  }

  static Future<ProfessionelSante?> getProfessionel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("professionel");
    if (data != null) {
      var decode = json.decode(data);
      var professionel = ProfessionelSante.fromJson(decode);
      sessionProfessionel = professionel;
      return professionel;
    }
    return null;
  }

  static Future<void> logOut() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    sessionProfessionel = null;
    await pref.remove("professionel");
  }
}
class ProfessionelService {
  static Future<ProfessionelSante?> infoProfessionel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("professionel");
    if (data != null) {
      var decode = json.decode(data);
      var profil = ProfessionelSante.fromJson(decode);
      return profil;
    }
    return null;
  }
}