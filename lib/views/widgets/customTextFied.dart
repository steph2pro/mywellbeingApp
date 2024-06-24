import 'package:flutter/material.dart';
class CustomTextFied {
  final String title;
  final String placeholder;
  final bool ispass;
  String err; 
  String _value='';
  CustomTextFied({this.title='',this.placeholder='',this.ispass=false,this.err='veillez remplir ce champ'});
TextFormField textfrofield(){
  return TextFormField(
    onChanged: (e){
      _value = e;
    },
    validator: (e) => e?.isEmpty ?? false ? this.err : null,
    obscureText: this.ispass,
    decoration: InputDecoration(
      hintText: this.placeholder,
      labelText: this.title,
      labelStyle: TextStyle(color: Colors.blueAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent)
      )
    ),
  );
}
  String get value{
    return _value;
  }

  }