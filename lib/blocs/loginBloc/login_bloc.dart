import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projects/services/authservice.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;
  LoginBloc(this._authService) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      final res = await _authService.signinUserWithEmailAndPassword(
          email: event.email, password:
      event.password
      );
      print('Login attempt result: $res');

      // Handling the response based on the result
      if (res == 'success') {
        print('Login successful: $res');
        emit(LoginSucces(isSucces: res));
      } else {
        print('Login failed: $res');
        emit(LoginFail(errMessage: res));
      }
    });
  }
}
