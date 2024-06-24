import 'package:flutter/material.dart';

class CalculImc extends StatefulWidget {
  @override
  _CalculImcState createState() => _CalculImcState();
}

class _CalculImcState extends State<CalculImc> {
  double _poids = 0.0;
  double _taille = 0.0;
  double _imc = 0.0;
  String _resultat = "";

  void _calculerIMC() {
    setState(() {
      if (_poids > 0.0 && _taille > 0.0) {
        _imc = _poids / (_taille * _taille);
        if (_imc < 18.5) {
          _resultat = "Maigreur";
        } else if (_imc < 25.0) {
          _resultat = "Poids normal";
        } else if (_imc < 30.0) {
          _resultat = "Surpoids";
        } else {
          _resultat = "Obésité";
        }
      } else {
        _imc = 0.0;
        _resultat = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculateur IMC',style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent[400],
      ),
      backgroundColor: Colors.white, // Couleur d'arrière-plan beige
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.white, // Couleur de la carte blanche
              elevation: 5.0, // Ombre de la carte
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Calculer votre IMC',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Poids (kg)',
                        hintText: 'Entrez votre poids en kg',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          _poids = double.tryParse(text) ?? 0.0;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Taille (m)',
                        hintText: 'Entrez votre taille en mètres',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        setState(() {
                          _taille = double.tryParse(text) ?? 0.0;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _calculerIMC();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Votre IMC est'),
                      content: Text('$_imc'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Fermer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Calculer IMC',
                style: TextStyle( color: Colors.white,),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              _resultat,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
