import 'package:encrypt/encrypt.dart';
 // Création de la clé de cryptage (128 bits)
  final key = Key.fromUtf8("abcdefghijklmnop"); // 16 caractères pour 128 bits
  final iv = IV.fromUtf8("hellotoutlemonde"); // 16 caractères pour l'IV

  // Fonction de cryptage
  String encrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }
//methode pour decrypter
String decrypt(String text){
  final encrypter=Encrypter(AES(key,mode:AESMode.cbc));
  final decrypt=encrypter.decrypt(Encrypted.from64(text),iv:iv);
  return decrypt;
}