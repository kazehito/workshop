
import 'package:flutter/material.dart';
import 'package:projects/Page/Bookings.dart';
import 'package:projects/Page/History.dart';
import 'package:projects/Page/Startpage.dart';
import 'package:projects/Page/createPost.dart';
import 'package:projects/Page/loginPage.dart';
import 'package:projects/Page/profilePage.dart';

import 'Page/Register.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/startpage':
        return MaterialPageRoute(builder: (_) => Startpage());
      case '/createpost':
        return MaterialPageRoute(builder: (_) => Createpost());
      case '/profilepage':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/booking':
        return MaterialPageRoute(builder: (_) => Bookings());
      case '/history':
        return MaterialPageRoute(builder: (_) => History());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}