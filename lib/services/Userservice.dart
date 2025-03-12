import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}