import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/models/user_info.dart';

class LogoutHandler extends StatefulWidget {
  static _LogoutHandler of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LogoutHandler>());

  @override
  _LogoutHandler createState() => new _LogoutHandler();
}

class _LogoutHandler extends State<LogoutHandler> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => logout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Logging you out of Proto...',
                style: TextStyle(fontSize: 35),
              ),
            ],
          ),
        ));
  }

  void logout() async {
    await UserInfoInheritedWidget.of(context).userInfo.resetUserInfo();
    print( UserInfoInheritedWidget.of(context).userInfo.getUserAttribute('display_name'));
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
