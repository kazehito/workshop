import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:projects/services/PostService.dart';
part 'get_post_event.dart';
part 'get_post_state.dart';

class GetPostBloc extends Bloc<GetPostEvent, GetPostState> {
  final PostServcice _postServcice;
  GetPostBloc(this._postServcice) : super(GetPostInitial()) {
    on<GetPost>((event, emit) {
      try {
        Stream<QuerySnapshot> postsStream = _postServcice.getPosts(event.provience);
        emit(PostLoaded(posts: postsStream));
      }
      catch (e) {
        emit(PostError(errMessage: e.toString()));
      }
    });
  }
}
