part of 'user_register_bloc.dart';

@immutable
sealed class UserRegisterState {}

final class UserRegisterInitial extends UserRegisterState {}

class RegisterSuccess extends UserRegisterState{
  final String? user;
  RegisterSuccess({required this.user});
}
class RegisterFail extends UserRegisterState{
  final String? errmessage;
  RegisterFail({required this.errmessage});
}