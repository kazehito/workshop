part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState{
  Map<String, dynamic> profile;
  ProfileSuccess({required this.profile});
}
class ProfileFail extends ProfileState{
  String errMessage;
  ProfileFail({required this.errMessage});
}
class GetQr extends ProfileState{
  String image;
  GetQr({required this.image});
}
class GetQrFail extends ProfileState{
  String errMessage;
  GetQrFail({required this.errMessage});
}
class PaymentInfoSuccess extends ProfileState{
  Map<String, dynamic> profile;
  PaymentInfoSuccess({required this.profile});
}
class PaymentInfoFail extends ProfileState{
  String errMessage;
  PaymentInfoFail({required this.errMessage});
}