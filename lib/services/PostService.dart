import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';

class PostServcice{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createPost(image, String title, String province, String address, String price) async {
    String? userId = _auth.currentUser?.uid;

    final file = File(image!.path);
    if (userId != null) {
      try {
        String? imageUrl = await uploadImage(file);
        if (imageUrl != null) {
          await _firestore
              .collection('posts')
              .add({
            'posterId': userId,
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
        print(jsonData['secure_url']);
        return jsonData['secure_url'];
      } else {
        print('Failed to upload image: ${jsonData['error']['message']}');
        return null;
      }
    }
    catch (e) {
      print('Error uploading image: $e');
      return null;
    }

  }
  Stream<QuerySnapshot> getPosts(String filter) {
    print('sssssssssssssss');
    print('Fetching posts for filter: $filter');

    try {
      print('sssssssssssssss');
      if (filter == 'all') {
        // For 'all', fetch all posts
        return FirebaseFirestore.instance
            .collection('posts')
            .snapshots()
            .map((snapshot) {
          // Check if the snapshot has documents
          if (snapshot.docs.isEmpty) {
            print('No posts found.');
          } else {
            // Print the number of documents in the snapshot
            print('Number of posts: ${snapshot.docs.length}');

            // Optionally, print each post document
            for (var post in snapshot.docs) {
              print('Post data: ${post.data()}');
            }
          }

          return snapshot; // Return the snapshot for the stream
        });
      } else {
        print('sssssdddddddddd');
        // For a specific province, fetch posts filtered by the province
        return FirebaseFirestore.instance
            .collection('posts')
            .where('province', isEqualTo: filter)
            .snapshots()
            .map((snapshot) {
          // Check if the snapshot has documents
          if (snapshot.docs.isEmpty) {
            print('No posts found for province: $filter');
          } else {
            // Print the number of documents in the snapshot
            print('Number of posts: ${snapshot.docs.length}');
            // Optionally, print each post document
            for (var post in snapshot.docs) {
              print('Post data: ${post.data()}');
            }
          }
          return snapshot; // Return the snapshot for the stream
        });
      }
    } catch (e) {
      // Handle any errors that occur during the Firestore query
      print('Error fetching posts: $e');
      return Stream.error(e);  // Return an error stream if an exception occurs
    }
  }





}