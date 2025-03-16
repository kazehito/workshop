import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
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
    on<SetQr>((event, emit) async {
      final res = await _userService.setQr(event.image);
      if(res != null){
        emit(GetQr(image: res));
      }else{
        emit(GetQrFail(errMessage: 'Something went wrong, please try again later'));
      }
    });
    on<GetPaymentInfo>((event, emit) async {
      final paymentprofile = await _userService.getPayment(event.uid);
      if(paymentprofile != null){
        emit(PaymentInfoSuccess(profile: paymentprofile));
      }
    });
  }
}
