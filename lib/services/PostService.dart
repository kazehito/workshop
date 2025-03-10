import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostServcice{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createPost(File image, String title, String province, String address, String price) async {
    String? userId = _auth.currentUser?.uid;

    if (userId != null) {
      try {
        String? imageUrl = await uploadImage(image);
        if (imageUrl != null) {
          await FirebaseFirestore.instance
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

          print('Post created successfully!');
        } else {
          print('Error uploading image.');
        }
      } catch (e) {
        print('Error creating post: $e');
      }
    } else {
      print('User is not logged in.');
    }
  }

// Function to upload image to Firebase Storage (same as before)
  Future<String?> uploadImage(File imageFile) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(imageFile);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

}