import 'package:ankev928/models/user_info.dart';
import 'package:ankev928/routing/route_generator.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new UserInfoInheritedWidget(
      userInfo: new UserInfo(),
      child: new MaterialApp(
        theme: ThemeData(
            primaryColor: Color(0xff83b71a),
            accentColor: Color(0xff343a40),
            backgroundColor: Color(0xfff1f1f1),
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
      ),
    );
  }
}
