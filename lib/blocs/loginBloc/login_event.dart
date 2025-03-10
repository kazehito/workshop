part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginUser extends LoginEvent {
  final String email;
  final String password;


  LoginUser({required this.email, required this.password});
}