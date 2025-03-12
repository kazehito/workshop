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