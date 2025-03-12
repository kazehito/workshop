import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/blocs/booking/booking_bloc.dart';
import 'package:projects/similiar/appcolors.dart';

class PostCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String province;
  final String address;
  final String price;
  final Timestamp createdAt;
  final String postersid;
  final String postid;

  const PostCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.province,
    required this.address,
    required this.price,
    required this.createdAt,
    required this.postersid,
    required this.postid
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight= MediaQuery.of(context).size.height;
    return Card(
      color: Colors.brown[400],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('', style: TextStyle(color: Colors.white),),
                Text(province, style: TextStyle(color: Colors.white),),
              ],
            ),
            Text(title, style: const TextStyle(fontSize: 20, color: Colors.white),),
            SizedBox(
              height: screenHeight/4,
              width: screenWidth,
              child: Image.network(imageUrl, fit: BoxFit.fill,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price: $price', style: TextStyle(color: Colors.white)),
                    InkWell(
                      onTap: (){
                        BlocProvider.of<BookingBloc>(context).add(Book(postid: postid, posterid : postersid));
                      },
                      child: Text('Book', style: TextStyle(color: Colors.white),),
                    )
                  ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}