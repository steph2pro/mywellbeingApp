import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:mywellbeing/views/widgets/customTextFied.dart';

String? globalImagePath; // Variable globale pour mémoriser le chemin de l'image

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  Uint8List? _image;
  String _imagepath = "";

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

  @override
  void initState() {
    super.initState();
    LoadImage();
  }

  // Fonction pour enregistrer l'image
  Future<String> saveImage(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final assetsPath = Directory('${directory.path}/assets/images/profiles');
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

  // Fonction pour le radio bouton
  String? selectedGender;

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
  }

  // Instanciation de l'objet pour faire les inputs
  CustomTextFied ageText = new CustomTextFied(
    title: "age",
    placeholder: "entrez votre age",
  );
  CustomTextFied tailleText = new CustomTextFied(
    title: "taille",
    placeholder: "entrez votre taille",
  );
  CustomTextFied poidsText = new CustomTextFied(
    title: "poids",
    placeholder: "entrez votre poids",
  );

  // Initialisation de la clé de validation
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    poidsText.err = "entrez le poids";
    tailleText.err = "entrez la taille";
    ageText.err = "entrez l'âge";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Well being",
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
                                    backgroundImage: AssetImage("assets/images/profile.png"),
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
                  ageText.textfrofield(),
                  SizedBox(height: 15,),
                  tailleText.textfrofield(),
                  SizedBox(height: 15,),
                  poidsText.textfrofield(),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    onPressed: () {
                      saveImagePath(_imagepath);
                      print(_imagepath);
                    },
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
                  SizedBox(height: 20,),
                  _imagepath.isNotEmpty
                      ? 
                          _image != null
                                ? Image.memory(
                                    _image!,
                                    height: 200,
                                    width: 200,
                                  )
                                : Container()
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
