import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future <Map<String, dynamic>?> getProfile() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? userId = auth.currentUser?.uid;
    try{
      final profile = await _firestore
        .collection('users')
        .doc(userId)
        .get();
      return profile.data();
    }
    catch(e) {
      return null;
    }
  }
  Future <String?> setQr(image) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? userId = auth.currentUser?.uid;
    final file = File(image!.path);
    try{
      String? imageUrl = await uploadImage(file);
      if(imageUrl !=null){
        await _firestore
            .collection('users')
            .doc(userId)
            .update({
          'QRpath' : imageUrl
        });
        return image;
      }

    }
    catch(e) {
      return null;
    }
    return null;
  }
  Future<String?> uploadImage(File imageFile) async {
    String cloudName = "dpaxku61i";
    final uploadPreset = "worshopPreset";
    try {
      var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);

      if (response.statusCode == 200) {
        return jsonData['secure_url'];
      } else {
        return null;
      }
    }
    catch (e) {
      return null;
    }

  }

  Future <Map<String, dynamic>?> getPayment(userId) async {
    try{
      final profile = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      return profile.data();
    }
    catch(e) {
      return null;
    }
  }
}