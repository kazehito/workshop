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
        return jsonData['secure_url'];
      } else {
        return null;
      }
    }
    catch (e) {
      print('Error uploading image: $e');
      return null;
    }

  }
  Stream<QuerySnapshot> getPosts(String filter) {
    try {
      if (filter == 'all') {
        return FirebaseFirestore.instance
            .collection('posts')
            .snapshots()
            .map((snapshot) {

          return snapshot;
        });
      } else {
        return FirebaseFirestore.instance
            .collection('posts')
            .where('province', isEqualTo: filter)
            .snapshots()
            .map((snapshot) {

          return snapshot;
        });
      }
    } catch (e) {

      return Stream.error(e);
    }
  }
  Future<String?> booking(postid,posterid) async {
    String? userId = _auth.currentUser?.uid;
    try{
      final res = FirebaseFirestore.instance
          .collection('booking')
          .add({
        'postID' : postid,
        'posterID' : posterid,
        'bookersID' : userId,
        'status' : 'Pending',
        'payment' : ''
      });
      return 'success';
    }
    catch(e){
      return null;
    }
  }

  Stream<QuerySnapshot> getbooking(){
    String? userId = _auth.currentUser?.uid;
    print(userId);
    try{
      return FirebaseFirestore.instance
          .collection('booking')
          .where('posterID', isEqualTo: userId)
          .snapshots();
    }
    catch(e){
      print(e);
      return Stream.error(e);
    }
  }

  Future <String> bookingStatus(bookid, status)async {
    try{
      print('sssssssss');
      FirebaseFirestore.instance
          .collection('booking')
          .doc(bookid)
          .update({
        'status' : status
      });
      return 'success';
    }
    catch (e){
      return 'fail';
      print(e);
    }
  }
  Stream<List<Map<String, dynamic>>> getHistory() async* {
    String? userId = _auth.currentUser?.uid;
    print(userId);
    try {
      await for (var bookingSnapshot in FirebaseFirestore.instance
          .collection('booking')
          .where('bookersID', isEqualTo: userId)
          .snapshots()) {

        List<Map<String, dynamic>> historyData = [];
        for (var bookingDoc in bookingSnapshot.docs) {
          String postId = bookingDoc['postID'];
          String status = bookingDoc['status'];

          var postSnapshot = await FirebaseFirestore.instance
              .collection('posts')
              .doc(postId)
              .get();

          String title = postSnapshot['title'];

          historyData.add({
            'status': status,
            'title': title,
          });
        }

        yield historyData;
      }
    } catch (e) {
      print('Error fetching history: $e');
      yield [];
    }
  }


}