
import 'package:flutter/material.dart';
import 'package:projects/Page/Startpage.dart';
import 'package:projects/Page/createPost.dart';
import 'package:projects/Page/loginPage.dart';

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