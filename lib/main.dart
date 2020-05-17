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
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
    );
  }
}
