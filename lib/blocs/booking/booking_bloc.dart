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
        final res = _postServcice.getbooking(event.uid);
        emit(BookGet(bookinglist: res));
      } catch (e) {
        emit(BookgetFail(failed: e.toString()));
      }
    });

    on<BookingStatus>((event, emit){
      _postServcice.bookingStatus(event.bookid, event.status);
    });

    on<GetHistory>((event, emit) async {
      try {
        await for (var res in _postServcice.getHistory(event.uid)) {
          if (res.isNotEmpty) {
            emit(HistoryGet(historyList: res));
            return;
          }
        }
        emit(BookgetFail(failed: 'No history found'));
      } catch (e) {
        emit(BookgetFail(failed: 'Something went wrong: $e'));
      }
    });

    on<PayEvent>((event, emit) async {
      final res = await _postServcice.pay(event.bookingid);
      if(res == 'success'){
        emit(PaymentSuccess(state: true));
      }
      else{
        emit(PaymentSuccess(state: false));
      }
    });
  }
}
