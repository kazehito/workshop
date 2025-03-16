import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projects/blocs/profileBloc/profile_bloc.dart';
import 'package:projects/services/Userservice.dart';
import 'package:projects/similiar/appcolors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserService _userService = UserService();
  String errmessage = '';
  late XFile _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }

  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
        context.read<ProfileBloc>().add(SetQr(image: _image));
      });
      debugPrint('Image selected: ${image.path}');
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.bars,
        title: Text("profile", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${state.profile['email']}',style: TextStyle(fontSize: 30, color: Colors.white)),
                      Text('Phone number: ${state.profile['phone']}',style: TextStyle(fontSize: 30, color: Colors.white)),
                      Text('QR:',style: TextStyle(fontSize: 30, color: Colors.white)),
                      IconButton(onPressed: (){pickImageFromGallery();}, icon: Icon(Icons.share_outlined), color: Colors.white,),
                      state.profile['QRpath'] != ''
                      ?Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: screenHeight/4,
                          width: screenWidth,
                            child: Center(child: Image.network(state.profile['QRpath'],))),
                      )
                      :Text("Add a QR", style: TextStyle(color: Colors.white, fontSize: 20),)
                    ],
                ),
              ),
            );
          } else if (state is ProfileFail) {
            return Center(
              child: Text(state.errMessage),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
