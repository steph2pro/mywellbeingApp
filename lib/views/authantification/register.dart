import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_recaptcha_v3/flutter_recaptcha_v2.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';
import 'package:mywellbeing/views/widgets/loading.dart';

class Register extends StatefulWidget {
  final VoidCallback toggle;
  Register({required this.toggle});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String erreur = "";
  bool _loading = false;
  String? selectedGender;
  bool _isCaptchaVerified = false;
  final _recaptchaV2Controller = RecaptchaV2Controller();

  // Fonction pour créer un compte utilisateur
  void creationCompte(String nom, String prenom, String email, String pass, String action, String? sexe) async {
    setState(() {
      erreur = "";
      _loading = true;
    });
    try {
      final response = await http.post(Uri.parse("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/userViewmodel.php"), body: {
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "pass": pass,
        "action": action,
        "sexe": sexe ?? "",
      });
      if (response.statusCode == 200) {
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
      } else {
        print("Erreur de connexion : ${response.statusCode}");
        print("Erreur : ${response.body}");
      }
    } catch (error) {
      print("Erreur de connexion : $error");
    }
  }

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
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
                                      selectedGender,
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
