import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mywellbeing/views/widgets/navBarWidget.dart';
import 'package:mywellbeing/views/widgets/loading.dart';

class RecetteAdd extends StatefulWidget {
  @override
  _RecetteAddState createState() => _RecetteAddState();
}

class _RecetteAddState extends State<RecetteAdd> {
  String _nom = '';
  String _description = '';
  String _propriete = '';
  String _ingredients = '';
  String _image = '';
  bool _loading = false;
  String _erreur = '';

  Future<void> ajouterRecette(String nom, String description, String propriete, String ingredients, String image) async {
    setState(() {
      _erreur = '';
      _loading = true;
    });

    final url = Uri.parse("https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/RecetteAdd.php");

    try {
      final response = await http.post(
        url,
        body: {
          'nom': nom,
          'description': description,
          'propriete': propriete,
          'ingredients': ingredients,
          'image': image,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);

        // Traiter la réponse ici si nécessaire

      } else {
        setState(() {
          _erreur = 'Erreur de réseau: ${response.statusCode}';
        });
        print('Erreur de réseau: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _erreur = 'Erreur lors de la requête: $e';
      });
      print('Erreur lors de la requête: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: const Text(
                "Programme",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montseraat',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            NavBarWidget(),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: _loading
          ? Loading()
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Ajouter une Recette',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _nom = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Propriété',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _propriete = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Ingrédients',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _ingredients = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _image = value;
                      });
                    },
                  ),
                  SizedBox(height: 26.0),
                  ElevatedButton(
                    onPressed: () {
                      ajouterRecette(_nom, _description, _propriete, _ingredients, _image);
                    },
                    child: Text(
                      'Ajouter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      fixedSize: Size(10, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (_erreur.isNotEmpty)
                    Text(
                      _erreur,
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
    );
  }
}
