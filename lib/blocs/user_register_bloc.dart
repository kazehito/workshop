import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projects/services/authservice.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  final AuthService _authService;

  UserRegisterBloc(this._authService) : super(UserRegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      // Access the properties of the RegisterUser event
      final res = await _authService.signupUserWithEmailAndPassword(
        phone: event.phone,
        email: event.email,
        password: event.password,
      );

      // Handle the response (you can add states to emit based on the result)
      if (res == 'success') {
        emit(RegisterSuccess(user: 'Success'));
      } else {
        emit(RegisterFail(errmessage: res.toString()));
      }
    });
  }
}
