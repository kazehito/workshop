part of 'get_post_bloc.dart';

@immutable
sealed class GetPostState {}

final class GetPostInitial extends GetPostState {}

class PostLoaded extends GetPostState {
  final Stream<QuerySnapshot> posts;

  PostLoaded({required this.posts});

}

class PostError extends GetPostState {
  final String errMessage;
  PostError({required this.errMessage});
}