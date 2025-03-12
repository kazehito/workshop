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