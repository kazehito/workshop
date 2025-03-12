import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:projects/services/Userservice.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserService _userService;

  ProfileBloc(this._userService) : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      final profile = await _userService.getProfile();
      if (profile != null) {
        emit(ProfileSuccess(profile: profile));
      } else if(profile == null){
        emit(ProfileFail(errMessage: 'Failed to load profile'));
      }
    });
  }
}
