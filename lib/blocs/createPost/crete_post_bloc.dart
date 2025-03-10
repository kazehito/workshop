import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:projects/services/PostService.dart';

part 'crete_post_event.dart';
part 'crete_post_state.dart';

class CretePostBloc extends Bloc<CretePostEvent, CretePostState> {
  final PostServcice _postServcice;
  CretePostBloc(this._postServcice) : super(CretePostInitial()) {
    on<CreatePost>((event, emit) {
      final res = _postServcice.createPost(event.image,
          event.title,
          event.province,
          event.address,
          event.price);
    });
  }
}
