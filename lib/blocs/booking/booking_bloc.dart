import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:projects/services/PostService.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final PostServcice _postServcice;
  BookingBloc(this._postServcice) : super(BookingInitial()) {
    on<Book>((event, emit) async {
      final res = await _postServcice.booking(event.postid, event.posterid);
      if(res != null){
        BookState(success: true);
      }else{
        BookState(success: false);
      }
    });
    on<ShowBook>((event, emit) async {
      try {
        final res = _postServcice.getbooking();
        print('asssssssssssss');
        print(res);
        emit(BookGet(bookinglist: res));
      } catch (e) {
        emit(BookgetFail(failed: e.toString()));
      }
    });

  }
}
