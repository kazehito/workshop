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
    context.read<BookingBloc>().add(ShowBook(uid: _auth.currentUser!.uid));
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking', style: TextStyle(color: Colors.white),),
        backgroundColor: AppColors.bars,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.primary,
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state is BookGet) {
              return StreamBuilder<QuerySnapshot>(
                stream: state.bookinglist,
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
                            height: MediaQuery.of(context).size.height / 4,
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
                                      onPressed: () {
                                        context.read<BookingBloc>().add(
                                            BookingStatus(bookid: document.id, status: "Rejected"));
                                      },
                                      icon: Icon(Icons.close, color: Colors.red),
                                    ),
                                  ],
                                )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No post available'));
                },
              );
            }
            return const Center(child: Text('No data to display'));
          },
        )

    );
  }
}
