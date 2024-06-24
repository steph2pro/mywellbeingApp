import 'package:flutter/material.dart';

class ActualiteAddWidget extends StatefulWidget {
  @override
  _ActualiteAddWidgetState createState() => _ActualiteAddWidgetState();
}

class _ActualiteAddWidgetState extends State<ActualiteAddWidget> {
  String _title = '';
  String _description = '';
  String _content = '';
  bool _isTextContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Ajouter une Actualite"),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Titre',
              ),
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
              ),
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Contenu : '),
                SizedBox(width: 8.0),
                DropdownButton<bool?>(
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
                    child: Text('Texte'),
                  ),
                  DropdownMenuItem<bool?>(
                    value: false,
                    child: Text('Image'),
                  ),
                ],
              ),
              ],
            ),
            SizedBox(height: 16.0),
            if (_isTextContent)
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contenu texte',
                ),
                onChanged: (value) {
                  setState(() {
                    _content = value;
                  });
                },
              )
            else
              ElevatedButton(
                child: Text('Choisir une image'),
                onPressed: () {
                  // Ajoute ici la logique pour choisir une image depuis la galerie
                },
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Ajouter'),
              onPressed: () {
                // Ajoute ici la logique pour sauvegarder l'actualité dans ta base de données
              },
            ),
          ],
        ),
      ),
      
    );
  }
}