import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostServcice{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createPost(image, String title, String province, String address, String price) async {
    String? userId = _auth.currentUser?.uid;
    print("aaaaaaaaaaaaaa");
    print('Image path: ${image.path}');
    final file = File(image!.path);
    if (userId != null) {
      try {
        String? imageUrl = await uploadImage(file);
        if (imageUrl != null) {
          await _firestore
              .collection('users')
              .doc(userId)
              .collection('posts')
              .add({
            'image_url': imageUrl,
            'title': title,
            'province': province,
            'address': address,
            'price': price,
            'created_at': FieldValue.serverTimestamp(),
          });

          print('Post created');
        } else {
          print('Error uploading image');
        }
      } catch (e) {
        print('Error creating post: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Debugging: Log upload progress
      print("Uploading image to Firebase Storage...");

      await storageRef.putFile(imageFile);

      // Once upload completes, get the URL of the uploaded image
      String downloadUrl = await storageRef.getDownloadURL();

      print("Image uploaded successfully: $downloadUrl");
      return downloadUrl;
    } catch (e) {

      print('Error uploading image: $e');
      return null;
    }
  }


}