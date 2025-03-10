part of 'crete_post_bloc.dart';

@immutable
sealed class CretePostEvent {}

class CreatePost extends CretePostEvent{
  final XFile image;
  final String title;
  final String province;
  final String address;
  final String price;

  CreatePost({required this.image, required this.title, required this.province, required this.address, required this.price});

}