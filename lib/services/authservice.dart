import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Object> signupUserWithEmailAndPassword({required String phone, required String email, required String password,}) async {
    try{
      UserCredential users = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = users.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'phone': phone,
        'QRpath' : ''
      });
      return 'success';
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'An error occurred during signup. Please try again.';
      }
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }
  Future<String> signinUserWithEmailAndPassword({required String email, required String password}) async {
    try{
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(user);
      return 'success';
    }
    on FirebaseAuthException catch(e){
      print(e.code);
      if(e.code == 'invalid-credential'){
        return "wrong password or email";
      }
      else {
      return 'An error occurred during Login. Please try again.';
      }
    } catch (e) {
      return 'An unexpected error occurred. Please try again.';
    }
  }
  Future<void> signOut() async{
    await _auth.signOut();
  }
}