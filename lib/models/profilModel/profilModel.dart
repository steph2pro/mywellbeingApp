import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile {
  final int id;
  final String age;
  final String taille;
  final String poids;
  final String villeResidence;
  final String objectif;
  final String photo;

  Profile({
    required this.id,
    required this.age,
    required this.taille,
    required this.poids,
    required this.villeResidence,
    required this.objectif,
    required this.photo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id_utilisateur'],
      age: json['age'],
      taille: json['taille'],
      poids: json['poids'],
      villeResidence: json['ville_residence'],
      objectif: json['objectifs'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id_utilisateur": id,
        "age": age,
        "taille": taille,
        "poids": poids,
        "ville_residence": villeResidence,
        "objectifs": objectif,
        "photo": photo,
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
