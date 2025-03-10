import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'crete_post_event.dart';
part 'crete_post_state.dart';

class CretePostBloc extends Bloc<CretePostEvent, CretePostState> {
  CretePostBloc() : super(CretePostInitial()) {
    on<CretePostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
