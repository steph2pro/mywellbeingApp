import 'package:flutter/material.dart';
import 'package:mywellbeing/api/api.dart';
import 'package:mywellbeing/models/userModel/postModel.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:mywellbeing/views/widgets/loading.dart';
import 'package:mywellbeing/views/widgets/navBarWidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

String? globalImagePath; // Variable globale pour mémoriser le chemin de l'image

class ActualiteAdd extends StatefulWidget {
  @override
  _ActualiteAddState createState() => _ActualiteAddState();
}
bool post=false;

class _ActualiteAddState extends State<ActualiteAdd> {

    Uint8List? _image;
  String _imagepath = "";
  String _title = '';
  String _description = '';
  String _content = '';
  bool _isTextContent = true;
  String erreur = "";
  bool _loading = false;

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
void addPost(String titre, String type, String contenu, String description, String id_utilisateur,)  async {
  setState(() {
      erreur = "";
      _loading = true;
    });
  try {

    final uri = Uri.parse('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/addPost.php');
    var response;
    if(_image ==null){
      final request = http.MultipartRequest('POST', uri)
      ..fields['titre'] = titre
      ..fields['type'] = type
      ..fields['contenu'] = contenu
      ..fields['description'] = description
      ..fields['id_utilisateur'] = id_utilisateur;
      var streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }else{
      final request = http.MultipartRequest('POST', uri)
      ..fields['titre'] = titre
      ..fields['type'] = type
      ..fields['contenu'] = contenu
      ..fields['description'] = description
      ..fields['id_utilisateur'] = id_utilisateur
      ..files.add(http.MultipartFile.fromBytes(
        'photo',
        _image!,
        filename: 'userImg_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ));
      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
    }
    
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
            //redirection de retour
            Navigator.pop(context);
          });
        } else {
          setState(() {
            erreur = result["message"];
            _loading = false;
          });
        }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erreur,textAlign: TextAlign.center,)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre actualite n\'as pas pu etre enregistre et poster',textAlign: TextAlign.center,)),
      );
    }
  } catch (e) {
    print('Error de l\'enregistrement: $e');
    // Gérer l'erreur ici, par exemple afficher un message d'erreur à l'utilisateur
  }
}



  
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        :Scaffold(
      appBar: AppBar(
         title:
            Row(
              children: [
                Expanded(
                  child: const Text("Actualite",
                  style:TextStyle(color: Colors.white,
                    fontFamily: 'Montseraat',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  ),
                  NavBarWidget()
              ]
            ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Ajouter une Actualite',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
           TextField(
              decoration: InputDecoration(
                labelText: 'Titre',
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
                  _title = value;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Contenu : ',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButton<bool?>(
                    value: _isTextContent,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _isTextContent = value;
                        });
                      }
                    },
                    items: [
                      DropdownMenuItem<bool?>(
                        value: true,
                        child: Text(
                          'Texte',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      DropdownMenuItem<bool?>(
                        value: false,
                        child: Text(
                          'Image',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (_isTextContent)
              TextField(
                
                decoration: InputDecoration(
                  labelText: "Contenu de l'actualite",
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
                    _content = value;
                  });
                },
                maxLines: null, // Permet un titrebre illimité de lignes
              )
            else
              ElevatedButton(
                onPressed: selectedImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.withOpacity(.5), // Couleur de fond du bouton
                   fixedSize: Size(10, 50), // Définir la taille du bouton (hauteur, largeur)
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Définir le rayon de la bordure
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Choisir une image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            
            SizedBox(height: 26.0),
            ElevatedButton(
             
              onPressed: post ? null:() async{
                setState(() {
                  post=true;
                });
                if(_title !='' && _description !='' || _content !='' ){
                  //recuperation de l'id de l'utilisateur
                  UserModel? user = await UserService.infoUser();
                  var id=user!.id_utilisateur;
                  addPost(
                     _title,
                     "Actualite",
                     _content,
                     _description,
                     id.toString()
                  );
                  print("******************messages ok************");
                  setState(() {
                    post=false;
                  });
                }
                print("******************messages champ vide************");
                // print( user!.id_utilisateur);
                // Ajoute ici la logique pour sauvegarder l'actualité dans ta base de données
              },
             child: Text('Ajouter',
               style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
             ),
             style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Couleur de fond du bouton
                   fixedSize: Size(10, 50), // Définir la taille du bouton (hauteur, largeur)
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // Définir le rayon de la bordure
                  ),
                ),
            ),
            SizedBox(height: 20,),
                _imagepath.isNotEmpty
                    ? _image != null
                        ? Image.memory(
                            _image!,
                            height: 200,
                            width: 300,
                          )
                        : Container()
                    : Container(),
            
          ],
        ),
      ),
      )
      
    );
  }
  
}
