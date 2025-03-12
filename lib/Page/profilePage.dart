import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile());
  }
  @override
  Widget build(BuildContext context) {
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
                      Center(child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuIy6HNc3zXzJ9-y-rNEfnaSdhcgeXytmnQg&s'))
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
