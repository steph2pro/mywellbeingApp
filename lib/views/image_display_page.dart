import 'dart:io';
import 'package:flutter/material.dart';
import 'database_helper.dart';

class ImageDisplayPage extends StatelessWidget {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<String?> _getImagePath() async {
    return await _dbHelper.getImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affichage de l\'image'),
      ),
      body: FutureBuilder<String?>(
        future: _getImagePath(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Aucune image trouvée'));
          } else {
            return Center(
              child: Image.file(File(snapshot.data!)),
            );
      }
    },
  ),
);
}
}