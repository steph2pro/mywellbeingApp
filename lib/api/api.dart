import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mywellbeing/crypte/encrypte.dart';
class Api{
  static addPost(Map data) async{
    try{
      final response=await http.post(Uri.parse(Url.urlPost),body:{
        "data": encrypt(jsonEncode(data))
      });
      print("Erreur : ${response.body}");
      if (response.statusCode == 200) {
          var result = jsonDecode(response.body);
          if(result[0]) return result;
          else return null;
          //print(result);
        } else {
          return null;
          print("Erreur de connexion 1: ${response.statusCode}");
          
        }
      }catch (error) {
      print("Erreur de connexion 2: $error");
    }
  }


 static getPost() async{
    try{
      final response=await http.get(Uri.parse(Url.getPost));
      print("Donne : ${response.body}");
      if (response.statusCode == 200) {
          return jsonDecode(response.body);
      }else return null;
      }catch (error) {
      print("Erreur de connexion 2: $error");
    }
  }
 static getMessage() async{
    try{
      final response=await http.get(Uri.parse(Url.getMessage));
      print("Donne : ${response.body}");
      if (response.statusCode == 200) {
          return jsonDecode(response.body);
      }else return null;
      }catch (error) {
      print("Erreur de connexion 2: $error");
    }
  }
  static getProfessionel() async{
    try{
      final response=await http.get(Uri.parse(Url.getPro));
      print("Donne : ${response.body}");
      if (response.statusCode == 200) {
          return jsonDecode(response.body);
      }else return null;
      }catch (error) {
      print("Erreur de connexion 2: $error");
    }
  }
}


//class pour les url
class Url{
  static String urlPost="https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/addPost.php";
  static String getPost="https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/readPost.php";
  static String getMessage="https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/readMessage.php";
  static String getPro="https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/readProf.php";
}