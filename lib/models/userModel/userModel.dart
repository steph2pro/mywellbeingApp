import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 
class UserModel{
  int id_utilisateur ;
  String nom;
  String prenom;
  String email;
  String sexe;
  String role;
  String photo;
  UserModel({
    required this.id_utilisateur ,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.sexe,
    required this.role,
    required this.photo,
    });
    //declaration de la variable pour contenire la session de l'utilisateur
    static late UserModel ? sessionUser;
  // factory UserModel.formJson( Map<String, dynamic> i )=>UserModel(
  //   id_utilisateur :i['id_utilisateur '],
  //   nom:i['nom'],
  //   prenom:i['prenom'],
  //   email:i['email'],
  //   sexe:i['sexe'],
  //   role:i['role'],
  // );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id_utilisateur: json['id_utilisateur'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      sexe: json['sexe'] ?? '',
      role: json['role'] ?? '',
      photo: json['photo'] ?? '',

    );
  }
  //methode pour transformer l'objet en map
  Map<String, dynamic> toMap()=>{
    "id_utilisateur":id_utilisateur,
    "nom":nom,
    "prenom":prenom,
    "email":email,
    "sexe":sexe,
    "role":role,
    "photo":photo,

  };
  //methode qui vas recuperer l'utilisateur et le stocker dans la memoire cahe
  //une metothe static est assessible meme sans avoir instancier un objet de cette class

  static saveUser( UserModel user) async{
    //instanciation du shared preference
    SharedPreferences pref = await SharedPreferences.getInstance();
    //conversion de l'utilisateur en chaine de caractere
    var data=json.encode(user.toMap());
    pref.setString("user", data);
   pref.commit();

  }
  //foction pour retourner un user
  static  getUser() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data= pref.getString("user");
   if (data != null) {
      var decode = json.decode(data);
      var user = await UserModel.fromJson(decode);
      sessionUser=user;
      print(sessionUser?.prenom);
      //
    }
  }
  //methode pour deconecter un utilisateur (le metre a null dans la base shered preference)
  static Future<void> logOut() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  //on met la variable sessionUser a null
  sessionUser=null;
  await pref.remove("user");
}
}
class UserService {
  static Future<UserModel?> infoUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = pref.getString("user");
    if (data != null) {
      var decode = json.decode(data);
      var user = UserModel.fromJson(decode);
      return user;
    }
    return null;
  }
}