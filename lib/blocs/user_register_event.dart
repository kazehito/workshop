part of 'user_register_bloc.dart';

@immutable
sealed class UserRegisterEvent {}

class RegisterUser extends UserRegisterEvent{
  final String email;
  final String password;
  final String phone;

  RegisterUser({required this.email, required this.password, required this.phone});
}