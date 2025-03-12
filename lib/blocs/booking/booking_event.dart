part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

class Book extends BookingEvent{
  String postid;
  String posterid;
  Book ({required this.postid, required this.posterid});
}

class ShowBook extends BookingEvent{
}
class BookingStatus extends BookingEvent{
  String status;
  String bookid;
  BookingStatus({required this.bookid, required this.status});
}
class GetHistory extends BookingEvent{}