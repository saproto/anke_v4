import 'package:ankev928/pages/calendar/calendar.dart';
import 'package:ankev928/pages/logout.dart';
import 'package:ankev928/pages/omnomcom/omnomcom_page.dart';
import 'package:ankev928/pages/photos/photo_albums_page.dart';
import 'package:ankev928/pages/quote/quote_corner_page.dart';
import 'file:///C:/Users/Marloes%20ten%20Hage/Documents/commisies/beheer/saproto_final_really/lib/pages/omnomcom/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/pages/homepage.dart';
import 'package:ankev928/pages/login.dart';
import 'package:ankev928/pages/loading_page.dart';
import 'package:ankev928/pages/news/news_page.dart';
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) { 
      case '/':
        return MaterialPageRoute(builder: (_) => LoadingPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginHandler());
      case '/logout':
        return MaterialPageRoute(builder: (_) => LogoutHandler());
      case '/news':
        return MaterialPageRoute(builder: (_) => NewsPage());
      case '/omnomcom':
        return MaterialPageRoute(builder: (_) => OmnomcomPage());
      case '/qrscanner':
      return MaterialPageRoute(builder: (_) => QrScannerPage());
      case '/photos':
        return MaterialPageRoute(builder: (_) => PhotoAlbumsPage());
      case '/quote':
        return MaterialPageRoute(builder: (_) => QuoteCornerPage());
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
