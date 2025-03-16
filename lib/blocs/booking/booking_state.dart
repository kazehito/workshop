part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

class BookState extends BookingState{
  bool success;
  BookState({required this.success});
}
class BookGet extends BookingState{
  final Stream<QuerySnapshot> bookinglist;

  BookGet({required this.bookinglist});
}
class BookgetFail extends BookingState{
  String failed;
  BookgetFail({ required this.failed});
}
class BookStatusSuccess extends BookingState{}

class HistoryGet extends BookingState{
  final List<Map<String, dynamic>> historyList;
  HistoryGet({required this.historyList});
}
class PaymentSuccess extends BookingState{
  bool state;
  PaymentSuccess({required this.state});
}