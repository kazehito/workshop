part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProfile extends ProfileEvent{

}
class SetQr extends ProfileEvent{
  XFile image;
  SetQr({required this.image});
}
class GetPaymentInfo extends ProfileEvent{
  String uid;
  GetPaymentInfo({required this.uid});
}