import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class ProfileUploadScreen extends StatefulWidget {
  const ProfileUploadScreen({super.key});
  @override
  _ProfileUploadScreenState createState() => _ProfileUploadScreenState();

}

class _ProfileUploadScreenState extends State<ProfileUploadScreen> {
  late File _image;
 // ProfileUploadScreen profileUploadScreen = ProfileUploadScreen();

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        moveImageToDirectory(_image);
      } else {
        print('Aucune image sélectionnée.');
      }
    });
  }

  Future<void> moveImageToDirectory(File image) async {
    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final savedImage = await image.copy('${appDir.path}/$fileName');
    print('Image déplacée vers : ${savedImage.path}');
  }
  @override
void initState() {
  super.initState();
  _image = File('assets/images/profile.png');
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload de photo de profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('Aucune image sélectionnée.')
                : Image.file(_image, height: 200.0),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Sélectionner une image'),
            ),
          ],
        ),
      ),
    );
  }
}
