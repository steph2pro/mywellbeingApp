import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'image_display_page.dart';

String? globalImagePath; // Variable globale pour mémoriser le chemin de l'image

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Uint8List? _image;
  String _imagepath = "";
  DatabaseHelper _dbHelper = DatabaseHelper();

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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image enregistrée avec succès'),
      ));
    }
  }

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
      await _dbHelper.saveImage(savedImage.path); // Save image path to SQLite
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

  @override
  void initState() {
    super.initState();
    loadImageFromDb();
  }

  void loadImageFromDb() async {
    String? imagePath = await _dbHelper.getImagePath();
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _imagepath = imagePath;
        globalImagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sélection d'image"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Sélectionnez et enregistrez une image',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
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
                              : CircleAvatar(
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
                                icon: _image != null ? Icon(Icons.check) : Icon(Icons.add_a_photo),
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
                ElevatedButton(
                  onPressed: () {
                    saveImagePath(_imagepath);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDisplayPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Enregistrer et Afficher',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
