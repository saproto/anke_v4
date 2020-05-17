import 'package:ankev928/pages/calendar/calendar.dart';
import 'package:ankev928/pages/logout.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/pages/homepage.dart';
import 'package:ankev928/pages/login.dart';
import 'package:ankev928/pages/loading_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) { 
      case '/':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginHandler());
      case '/logout':
        return MaterialPageRoute(builder: (_) => LogoutHandler());
      default:
        return _errorRoute("unkonw route");
    }
  }

  static Route<dynamic> _errorRoute(String errorMessage) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(errorMessage),
        ),
      );
    });
  }
}
