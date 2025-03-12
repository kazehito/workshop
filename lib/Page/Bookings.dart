import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/blocs/booking/booking_bloc.dart';
import 'package:projects/similiar/appcolors.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookingBloc>(context).add(ShowBook());
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bars,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.primary,
      body: StreamBuilder<QuerySnapshot>(
          stream: context.read<BookingBloc>().state is BookGet
              ? (context.read<BookingBloc>().state as BookGet).bookinglist
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      height: screenHeight/4,
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${document['bookersID']} : wants to join your event',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          document['status'],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        document['status'] == "Pending"
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<BookingBloc>().add(
                                    BookingStatus(bookid: document.id, status: "Accepted"));
                              },
                              icon: Icon(Icons.check, color: Colors.yellow),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                          ],
                        )
                            : SizedBox(), // Use SizedBox() instead of null
                      ],
                    ),
                  ),
                  );
                },
              );
            }
            return const Center(child: Text('No posts available'));
          }
      ),
    );
  }
}
