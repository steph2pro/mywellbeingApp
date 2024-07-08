import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mywellbeing/models/userModel/professionelModel.dart';
import 'dart:convert';
import 'package:mywellbeing/models/userModel/userModel.dart';
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
class Professionel extends StatefulWidget {
  
  

  @override
  State<Professionel> createState() => _ProfessionelState();
}

class _ProfessionelState extends State<Professionel> {
  //variable pour l'image
   Uint8List? _image;
  String _imagepath = "";
  String erreur = "";
  bool _loading = false;
  String? selectedGender;
  
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
void creationComptePro(String specialite, String horaire, String disponibilite, String description, String action, String id_utilisateur)  async {
  setState(() {
      erreur = "";
      _loading = true;
    });
  try {

    final uri = Uri.parse('https://mywellbeing.000webhostapp.com/my_wellbeing/viewmodels/professionelViewmodel.php');
    final request = http.MultipartRequest('POST', uri)
      ..fields['specialite'] = specialite
      ..fields['horaire'] = horaire
      ..fields['description'] = description
      ..fields['disponibilite'] = disponibilite
      ..fields['action'] = action
      ..fields['id_utilisateur'] = id_utilisateur
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
       var data = jsonDecode(response.body);
        var result = data['data'];
        int success = result["success"];
        print(data);
        if (success == 1) {
          setState(() {
            _loading = false;
            erreur = result["message"];
            var professionel=result["professionel"];
            print ("**************Prof***************");
            print(professionel);
            ProfessionelSante.saveProf(ProfessionelSante.fromJson(professionel));
            print ("**************ENREGISTREMENT***************");
           // Professionel.
            //redirection de retour
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
            Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('votre profil n\'as pas pu etre enregistre')),
      );
    }
  } catch (e) {
    print('Error de l\'enregistrement: $e');
    // Gérer l'erreur ici, par exemple afficher un message d'erreur à l'utilisateur
    setState(() {
      _loading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Impossible d\'effectuer cette opération. Vérifiez votre connexion internet')),
    );
  }
}



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
  CustomTextFied specialiteText = CustomTextFied(
    title: "specialite",
    placeholder: "entrez votre specialite",
  );
  CustomTextFied horaireText = CustomTextFied(
    title: "horaire",
    placeholder: "entrez votre horaire de travail",
  );
  CustomTextFied disponibiliteText = CustomTextFied(
    title: "disponibilite",
    placeholder: "entrez votre disponibilite",
  );
  CustomTextFied descText = CustomTextFied(
    title: "description",
    placeholder: "entrez une breve description de vous",
  );

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
 
    return _loading
        ? Loading()
        : Scaffold(
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
                          'Remplissez votre compte de Professionel de sante',
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
                        SizedBox(height: 30),
                        specialiteText.textfrofield(),
                        SizedBox(height: 15),
                        horaireText.textfrofield(),
                        SizedBox(height: 15),
                        disponibiliteText.textfrofield(),
                        SizedBox(height: 15),
                        descText.textfrofield(),
                        
                        SizedBox(height: 15),
                        
                        ElevatedButton(
                          onPressed:() async{
                                  if (_key.currentState?.validate() ?? false) {
                                    UserModel? user = await UserService.infoUser();
                                    var id=user!.id_utilisateur;
                                    creationComptePro(specialiteText.value, horaireText.value, disponibiliteText.value, descText.value, "create", id.toString());
                                   
                                  }
                                },
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
