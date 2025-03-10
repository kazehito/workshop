import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/Page/Register.dart';
import 'package:projects/blocs/loginBloc/login_bloc.dart';
import 'package:projects/services/authservice.dart';
import 'Routes.dart';
import 'blocs/userRegisterBloc/user_register_bloc.dart';
import 'firebase_options.dart';



void main() async {
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
