import 'package:flutter/cupertino.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetHistory());
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
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {

          if (state is HistoryGet) {
            var historyList = state.historyList;
            if (historyList.isEmpty) {
              return const Center(child: Text('No history available'));
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
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No posts available'));
        },
      ),
    );
  }
}
