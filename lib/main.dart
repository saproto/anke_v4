import 'package:ankev928/pages/calendar/calendar.dart';
import 'package:ankev928/pages/committees/committees_page.dart';
import 'package:ankev928/pages/homepage/homepage.dart';
import 'package:ankev928/pages/loading_page.dart';
import 'package:ankev928/pages/login.dart';
import 'package:ankev928/pages/logout.dart';
import 'package:ankev928/pages/news/news_page.dart';
import 'package:ankev928/pages/omnomcom/omnomcom_page.dart';
import 'package:ankev928/pages/omnomcom/qr_scanner.dart';
import 'package:ankev928/pages/photos/photo_albums_page.dart';
import 'package:ankev928/pages/quote/add_quote_page.dart';
import 'package:ankev928/pages/quote/quote_corner_page.dart';

import 'services/activity_list_service.dart';
import 'services/news_article_list_service.dart';
import 'services/user_info_service.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UserInfoService>(UserInfoService());
  getIt.registerSingleton<NewsArticleListService>(NewsArticleListService());
  getIt.registerSingleton<ActivityListService>(ActivityListService());

//  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xff83b71a),
          accentColor: Color(0xff343a40),
          backgroundColor: Color(0xfff1f1f1),
          errorColor: Color(0xffC50005),
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'poppins',
                  color: const Color(0xff343a40)),
              bodyText2: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'poppins',
                  color: const Color(0xff6c757d)))),
//        initialRoute: '/',
//        onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
      routes: {
        '/': (context) => new LoadingPage(),
        '/home': (context) => new HomePage(),
        '/calendar': (context) => new CalendarPage(),
        '/news': (context) => new NewsPage(),
        '/login': (context) => new LoginHandler(),
        '/logout' : (context) => new LogoutHandler(),
        '/omnomcom' : (context) => new OmnomcomPage(),
        '/qrscanner' : (context) => new QrScannerPage(),
        '/photos': (context) => new PhotoAlbumsPage(),
        '/quote' : (context) => new QuoteCornerPage(),
        '/addQuote' : (context) => new AddQuotePage(),
        '/committees' : (context) => new CommitteesPage()
      },
    );
  }
}
