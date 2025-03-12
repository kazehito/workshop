import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/Page/postCard.dart';
import 'package:projects/services/authservice.dart';
import 'package:projects/similiar/appcolors.dart';

import '../blocs/getPostBloc/get_post_bloc.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  TextEditingController provinceControl_ = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  User? _user;
  String selectedProvince = 'all';
  String errmessage = '';

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
      if (_user != null) {
        print("User is logged in: ${_user!.email}");
      } else {
        print("No user logged in");
      }
    });
    BlocProvider.of<GetPostBloc>(context).add(GetPost(provience: selectedProvince));
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight= MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leadingWidth: screenWidth/2.8,
        backgroundColor: AppColors.bars,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.brown,
            child: DropdownButton<String>(
              value: selectedProvince,
              onChanged: (newValue) {
                setState(() {
                  selectedProvince = newValue!;
                });
                // Trigger BLoC event when province changes
                BlocProvider.of<GetPostBloc>(context)
                    .add(GetPost(provience: selectedProvince));
              },
              items: [
                DropdownMenuItem(value: 'province1', child: Text("province1")),
                DropdownMenuItem(value: 'province2', child: Text("province2")),
                DropdownMenuItem(value: 'province3', child: Text("province3")),
                DropdownMenuItem(value: 'province4', child: Text("province4")),
                DropdownMenuItem(value: 'all', child: Text("all")),
              ],
            ),
          ),
        ),
        title: Text("Workshop", style: TextStyle(color: Colors.white),),
        actions: [
          _user == null
          ?Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.btn1,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text('Login', style: TextStyle(color: Colors.white),)),
              ),
            ),
          )
          :Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                authService.signOut();
                Navigator.pushNamed(context, '/startpage');
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.btn1,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(child: Text('Logout', style: TextStyle(color: Colors.white),)),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _user != null?
      BottomAppBar(
        height: screenHeight/20,
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.person, size: 40,), onPressed: () {
              Navigator.pushNamed(context, '/profilepage');
            }),
            IconButton(icon: Icon(Icons.add, size: 40,), onPressed: () {
              Navigator.pushNamed(context, '/createpost');
            }),
            IconButton(icon: Icon(Icons.history, size: 40,), onPressed: () {
              Navigator.pushNamed(context, '/profilepage');
            }),
            IconButton(icon: Icon(Icons.book_outlined, size: 40,), onPressed: () {
              Navigator.pushNamed(context, '/booking');
            }),
          ],
        ),
      )
      : null,
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<GetPostBloc>().state is PostLoaded
              ? (context.read<GetPostBloc>().state as PostLoaded).posts
              : null,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document = snapshot.data!.docs[index];
                  return PostCard(
                    imageUrl: document['image_url'],
                    title: document['title'],
                    province: document['province'],
                    address: document['address'],
                    price: document['price'],
                    createdAt: document['created_at'],
                    postersid:  document['posterId'],
                    postid: document.id,
                  );
                },
              );
            }
            return const Center(child: Text('No posts available'));
          }
        )

    );
  }
}

