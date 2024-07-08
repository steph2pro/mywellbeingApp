import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile {
  final int idProfil;
  final int id;
  final String age;
  final String taille;
  final String poids;
  final String villeResidence;
  final String objectif;

  Profile({
    required this.idProfil,
    required this.id,
    required this.age,
    required this.taille,
    required this.poids,
    required this.villeResidence,
    required this.objectif,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      idProfil: json['id_profil'],
      id: json['id_utilisateur'],
      age: json['age'],
      taille: json['taille'],
      poids: json['poids'],
      villeResidence: json['ville_residence'],
      objectif: json['objectifs'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id_profil": idProfil,
        "id_utilisateur": id,
        "age": age,
        "taille": taille,
        "poids": poids,
        "ville_residence": villeResidence,
        "objectifs": objectif
      };

  static late Profile? sessionProfile;

  static Future<void> saveProfile(Profile profile) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = json.encode(profile.toMap());
    pref.setString("profile", data);
    pref.commit();
  }

  static Future<Profile?> getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("profile");
    if (data != null) {
      var decode = json.decode(data);
      var profile = Profile.fromJson(decode);
      sessionProfile = profile;
      return profile;
    }
    return null;
  }

  static Future<void> logOut() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    sessionProfile = null;
    await pref.remove("profile");
  }
}
class ProfilService {
  static Future<Profile?> infoProfil() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("profile");
    if (data != null) {
      var decode = json.decode(data);
      var profil = Profile.fromJson(decode);
      return profil;
    }
    return null;
  }
}