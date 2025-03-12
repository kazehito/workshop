import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projects/Page/Register.dart';
import 'package:projects/blocs/booking/booking_bloc.dart';
import 'package:projects/blocs/loginBloc/login_bloc.dart';
import 'package:projects/blocs/profileBloc/profile_bloc.dart';
import 'package:projects/services/PostService.dart';
import 'package:projects/services/Userservice.dart';
import 'package:projects/services/authservice.dart';
import 'Routes.dart';
import 'blocs/createPost/crete_post_bloc.dart';
import 'blocs/getPostBloc/get_post_bloc.dart';
import 'blocs/userRegisterBloc/user_register_bloc.dart';
import 'firebase_options.dart';



void main() async {
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: 'dpaxku61i');
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding inside main()
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserRegisterBloc>(
          create: (context) => UserRegisterBloc(AuthService()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(AuthService()),
        ),
        BlocProvider<CretePostBloc>(
          create: (context) => CretePostBloc(PostServcice()),
        ),
        BlocProvider<GetPostBloc>(
          create: (context) => GetPostBloc(PostServcice()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(UserService()),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(PostServcice()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/startpage',
        onGenerateRoute: RouteGen.generateRoute,
        home: RegisterPage(),
      )
    );
  }
}
