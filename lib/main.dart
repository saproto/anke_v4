import 'routing/route_generator.dart';

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
    return  new MaterialApp(
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
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      );
  }
}
