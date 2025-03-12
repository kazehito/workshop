part of 'get_post_bloc.dart';

@immutable
sealed class GetPostEvent {}

class GetPost extends GetPostEvent{
  final String provience;
  GetPost({required this.provience});
}