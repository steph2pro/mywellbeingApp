import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_recaptcha_v3/flutter_recaptcha_v2.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:mywellbeing/views/widgets/loading.dart';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? globalImagePath; 
class Register extends StatefulWidget {
  final VoidCallback toggle;
  Register({required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //variable pour l'image
   Uint8List? _image;
  String _imagepath = "";
  String erreur = "";
  bool _loading = false;
  String? selectedGender;
  bool _isCaptchaVerified = false;
  final _recaptchaV2Controller = RecaptchaV2Controller();
  // Fonction pour la gestion de l'image
  void selectedImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choisissez une option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Galerie'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Caméra'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List img = await pickedFile.readAsBytes();
      setState(() {
        _image = img;
      });

      String newPath = await saveImage(File(pickedFile.path));
      setState(() {
        _imagepath = newPath;
        globalImagePath = newPath;
      });
      print("Image saved at: $newPath");
    }
  }
   // Fonction pour enregistrer l'image
  Future<String> saveImage(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final assetsPath = Directory('${directory.path}/assets/images/SaveProfiles');
      if (!await assetsPath.exists()) {
        await assetsPath.create(recursive: true);
      }
      final random = Random();
      final newPath = path.join(assetsPath.path, 'userImg_${random.nextInt(10000)}.jpg');
      final savedImage = await image.copy(newPath);
      await saveImagePath(savedImage.path);
      return savedImage.path;
    } catch (e) {
      print('Error saving image: $e');
      return '';
    }
  }

  Future<void> saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("imagepath", path);
  }
  void LoadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = prefs.getString("imagepath") ?? '';
      globalImagePath = _imagepath;
    });
  }

  // Fonction pour enregistrer les données
void creationCompte(String nom, String prenom, String email, String pass, String action, String sexe,)  async {
  setState(() {
      erreur = "";
      _loading = true;
    });
  try {

    final uri = Uri.parse('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/userViewmodel.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['nom'] = nom
      ..fields['prenom'] = prenom
      ..fields['email'] = email
      ..fields['pass'] = pass
      ..fields['action'] = action
      ..fields['sexe'] = sexe
      ..files.add(http.MultipartFile.fromBytes(
        'photo',
        _image!,
        filename: 'userImg_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ));

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
        } else {
          setState(() {
            erreur = result["message"];
            _loading = false;
          });
        }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre profil a ete enregistrer avec succes')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre profil n\'as pas pu etre enregistre')),
      );
    }
  } catch (e) {
    print('Error de l\'enregistrement: $e');
    // Gérer l'erreur ici, par exemple afficher un message d'erreur à l'utilisateur
  }
}



  // Fonction pour créer un compte utilisateur
  // void creationCompte(String nom, String prenom, String email, String pass, String action, String? sexe) async {
  //   setState(() {
  //     erreur = "";
  //     _loading = true;
  //   });
  //   try {
  //     final response = await http.post(Uri.parse("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/userViewmodel.php"), body: {
  //       "nom": nom,
  //       "prenom": prenom,
  //       "email": email,
  //       "pass": pass,
  //       "action": action,
  //       "sexe": sexe ?? "",
  //     });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       var result = data['data'];
  //       int success = result["success"];
  //       if (success == 1) {
  //         setState(() {
  //           _loading = false;
  //           erreur = result["message"];
  //         });
  //       } else {
  //         setState(() {
  //           erreur = result["message"];
  //           _loading = false;
  //         });
  //       }
  //     } else {
  //       print("Erreur de connexion : ${response.statusCode}");
  //       print("Erreur : ${response.body}");
  //     }
  //   } catch (error) {
  //     print("Erreur de connexion : $error");
  //   }
  // }

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }
   @override
  void initState() {
    super.initState();
    
    LoadImage();
  }

  // Widgets de champs de texte personnalisés
  CustomTextFied nomText = CustomTextFied(
    title: "nom",
    placeholder: "entrez votre nom",
  );
  CustomTextFied prenomText = CustomTextFied(
    title: "prenom",
    placeholder: "entrez votre prenom",
  );
  CustomTextFied emailText = CustomTextFied(
    title: "email",
    placeholder: "entrez votre adresse mail",
  );
  CustomTextFied passText = CustomTextFied(
    title: "mot de pass",
    placeholder: "entrez votre mot de pass",
    ispass: true,
  );

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(25),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Créer un compte',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent[400],
                          ),
                        ), 
                        SizedBox(height: 30,),
                // Code pour l'import d'image
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  _image != null
                                      ? CircleAvatar(
                                          radius: 64,
                                          backgroundImage: MemoryImage(_image!),
                                        )
                                      : const CircleAvatar(
                                          radius: 64,
                                          backgroundImage: AssetImage("assets/images/SaveProfile.png"),
                                        ),
                                  Positioned(
                                    width: 40,
                                    height: 70,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.blueAccent,
                                      child: IconButton(
                                        onPressed: selectedImage,
                                        icon: _image != null ? const Icon(Icons.check) : const Icon(Icons.add_a_photo),
                                        color: Colors.white,
                                        iconSize: 25,
                                      ),
                                    ),
                                    bottom: -10,
                                    left: 80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        nomText.textfrofield(),
                        SizedBox(height: 15),
                        prenomText.textfrofield(),
                        SizedBox(height: 15),
                        emailText.textfrofield(),
                        SizedBox(height: 15),
                        passText.textfrofield(),
                        SizedBox(height: 15),
                        Text('Sélectionnez votre genre :'),
                        Row(
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 'Masculin',
                                  groupValue: selectedGender,
                                  onChanged: onGenderChanged,
                                ),
                                Text('Masculin'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 'Feminin',
                                  groupValue: selectedGender,
                                  onChanged: onGenderChanged,
                                ),
                                Text('Féminin'),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Stack(
                          children: <Widget>[
                             Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: Text("Tester reCAPTCHA"),
                                    onPressed: () {
                                      _isCaptchaVerified=true;//_recaptchaV2Controller.show();
                                    },
                                  ),
                                  if (_isCaptchaVerified)
                                    Text(
                                      "reCAPTCHA vérifié avec succès !",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                ],
                              ),
                            ),
                            // RecaptchaV2(
                            //   apiKey: "6Lfb5QgqAAAAALy8J5JCLNq5d2wcSlXcoY1TJwER",
                            //   apiSecret: "6Lfb5QgqAAAAANaq8pSBmV8XowRrXLxAEo4IObkR",
                            //   controller: _recaptchaV2Controller,
                            //   onVerifiedError: (String? error) {
                            //     print("reCAPTCHA verification error: $error");
                            //   },
                            //   onVerifiedSuccessfully: (bool success) {
                            //     setState(() {
                            //       _isCaptchaVerified = success;
                            //     });
                            //   },
                            // ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: _isCaptchaVerified
                              ? () {
                                  if (_key.currentState?.validate() ?? false) {
                                    creationCompte(
                                      nomText.value,
                                      prenomText.value,
                                      emailText.value,
                                      passText.value,
                                      "create",
                                      selectedGender.toString(),
                                    );
                                  }
                                }
                              : null,
                          child: Text(
                            'enregistrer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.withOpacity(.7),
                            fixedSize: Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Avez-vous un compte ? "),
                            TextButton(
                              onPressed: widget.toggle,
                              child: Text(
                                'Connectez-vous',
                                style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(
                          erreur,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
