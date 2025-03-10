import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/services/authservice.dart';
import 'package:projects/similiar/appcolors.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  User? _user;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes to get the current user status
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
        leading: Container(
          color: Colors.brown,
          child: DropdownMenu(
            textStyle: TextStyle(color: Colors.white),
            initialSelection: Text("all"),
            label: Text("province", style: TextStyle(color: Colors.white),),
              dropdownMenuEntries: <DropdownMenuEntry<Color>>[
            DropdownMenuEntry(value: Colors.white, label: "province1"),
            DropdownMenuEntry(value: Colors.white, label: "province2"),
            DropdownMenuEntry(value: Colors.white, label: "province3"),
            DropdownMenuEntry(value: Colors.white, label: "province4"),
            DropdownMenuEntry(value: Colors.white, label: "all"),
          ]),
        ),
        title: Text("Workshop", style: TextStyle(color: Colors.white),),
        actions: [
          _user == null
          ?InkWell(
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
          )
          :InkWell(
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
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: screenHeight/20,
        color: Colors.orange,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(icon: Icon(Icons.add, size: 40,), onPressed: () {
              Navigator.pushNamed(context, '/createpost');
            }),
          ],
        ),
      ),
    );
  }
}

