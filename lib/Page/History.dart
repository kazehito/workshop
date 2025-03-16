import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/booking/booking_bloc.dart';
import '../similiar/appcolors.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetHistory(uid: _auth.currentUser!.uid));
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: TextStyle(color: Colors.white),),
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
          if (state is HistoryGet) {
            var historyList = state.historyList;
            if (historyList.isEmpty) {
              return const Center(child: Text('No posts available'));
            }
            return ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                var document = historyList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: screenHeight / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          document['title'],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          document['status'],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        document['paymentStatus'] != ''?
                        Text("Payment : Payed", style: TextStyle(color: Colors.white, fontSize:  20),)
                            :Text("Payment: unpaid",style: TextStyle(color: Colors.white, fontSize:  20)),
                        document['status'] == 'Accepted'
                          ?InkWell(
                          onTap: (){
                            context.read<BookingBloc>().add(PayEvent(bookingid: document['bookingID']));
                            Navigator.popAndPushNamed(context, '/payment', arguments: {'uid': document['posterID']});
                          },

                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth/2,
                                decoration: BoxDecoration(
                                  color: AppColors.btn1,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(child: Text('Pay', style: TextStyle( color: Colors.white, fontSize: 20),)),
                              ),
                            ),
                          )
                          : Container(),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No post available'));
        },
      ),
    );
  }
}
