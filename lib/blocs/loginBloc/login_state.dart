part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginSucces extends LoginState{
  final String isSucces;
  LoginSucces({required this.isSucces});
}
class LoginFail extends LoginState{
  final String errMessage;
  LoginFail({required this.errMessage});
}
