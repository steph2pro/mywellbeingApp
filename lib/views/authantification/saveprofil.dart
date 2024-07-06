import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mywellbeing/models/userModel/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mywellbeing/views/widgets/customTextFied.dart';

String? globalImagePath; // Variable globale pour mémoriser le chemin de l'image

class SaveProfil extends StatefulWidget {
  const SaveProfil({super.key});

 

  @override
  State<SaveProfil> createState() => _SaveProfilState();
}

class _SaveProfilState extends State<SaveProfil> {
  Uint8List? _image;
  String _imagepath = "";

  // Controllers for the text fields 
  final TextEditingController ageController = TextEditingController();
  final TextEditingController tailleController = TextEditingController();
  final TextEditingController poidsController = TextEditingController();
  final TextEditingController villeController = TextEditingController();
  final TextEditingController objectifController = TextEditingController();

// Initialisation de la clé de validation
  final _key = GlobalKey<FormState>();
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
  
    var id_utilisateur="1";
   //lecture de l'utilisateur
  
  UserModel? _user;
  @override
  void initState() {
    super.initState();
    _loadUser();
    LoadImage();
  }

  void _loadUser() async {
    UserModel? user = await UserService.infoUser();
    setState(() {
      _user = user;
    }); 
    if(_user != null){
      var id=_user!.id_utilisateur;
      id_utilisateur=id.toString();
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
Future<void> registerSaveProfile() async {
  try {
    final age = ageController.text;
    final taille = tailleController.text;
    final poids = poidsController.text;
    final ville = villeController.text;
    final objectif = objectifController.text;
    final id = id_utilisateur;
    if (_image == null || age.isEmpty || taille.isEmpty || poids.isEmpty || ville.isEmpty || objectif.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required')),
      );
      return;
    }

    final uri = Uri.parse('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/saveprofil.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['age'] = age
      ..fields['taille'] = taille
      ..fields['poids'] = poids
      ..fields['ville'] = ville
      ..fields['id_utilisateur'] = id
      ..fields['objectif'] = objectif
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
      print('Response body: $responseBody'); // Afficher la réponse dans la console
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre profil a ete enregistrer avec succes')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre profil n\'as pas pu etre enregistre')),
      );
    }
  } catch (e) {
    print('Error registering SaveProfile: $e');
    // Gérer l'erreur ici, par exemple afficher un message d'erreur à l'utilisateur
  }
}




 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        "My Wellbeing",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.blueAccent[400],
    ),
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
                  'Créer votre profil utilisateur',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blueAccent[400]),
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
                SizedBox(height: 30,),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    errorText: ageController.text.isEmpty ? 'entrez l\'âge' : null,
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: tailleController,
                  decoration: InputDecoration(
                    labelText: 'Taille (cm)',
                    errorText: tailleController.text.isEmpty ? 'entrez la taille' : null,
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: poidsController,
                  decoration: InputDecoration(
                    labelText: 'Poids (kg)',
                    errorText: poidsController.text.isEmpty ? 'entrez le poids' : null,
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: villeController,
                  decoration: InputDecoration(
                    labelText: 'Ville de résidence',
                    errorText: villeController.text.isEmpty ? 'entrez la ville de résidence' : null,
                  ),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: objectifController,
                  decoration: InputDecoration(
                    labelText: 'Objectif',
                    errorText: objectifController.text.isEmpty ? 'entrez votre objectif' : null,
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: registerSaveProfile,
                  child: Text(
                    'Enregistrer',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.withOpacity(.7),
                    fixedSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // SizedBox(height: 20,),
                // _imagepath.isNotEmpty
                //     ? _image != null
                //         ? Image.memory(
                //             _image!,
                //             height: 200,
                //             width: 200,
                //           )
                //         : Container()
                //     : Container(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

}
