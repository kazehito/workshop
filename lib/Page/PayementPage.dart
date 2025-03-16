import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/profileBloc/profile_bloc.dart';
import '../similiar/appcolors.dart';

class Payment extends StatefulWidget {
  final String uid;
  const Payment({required this.uid, super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late String uid;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetPaymentInfo(uid: widget.uid));
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
        title: Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is PaymentInfoSuccess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${state.profile['email']}', style: TextStyle(fontSize: 30, color: Colors.white)),
                    Text('Phone number: ${state.profile['phone']}', style: TextStyle(fontSize: 30, color: Colors.white)),
                    Text('QR:', style: TextStyle(fontSize: 30, color: Colors.white)),
                    state.profile['QRpath'] != ''
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: screenHeight / 4,
                        width: screenWidth,
                        child: Center(child: Image.network(state.profile['QRpath'])),
                      ),
                    )
                        : Text("QR not available", style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            );
          } else if (state is ProfileFail) {
            return Center(child: Text(state.errMessage));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
