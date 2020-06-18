import 'package:ankev928/shared/api_call.dart';
import 'package:flutter/material.dart';


import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/models/user_info.dart';

class LoginHandler extends StatefulWidget {
  static _LoginHandlerState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoginHandlerState>());

  @override
  _LoginHandlerState createState() => new _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => login());
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
                'Logging you into Proto...',
                style: TextStyle(fontSize: 35),
              )
            ],
          ),
        ));
  }

  void login() async {
    Map<String, dynamic> userInfo = await requestApiCallResult('user/info');
    print(userInfo);
    UserInfoInheritedWidget.of(context).userInfo.updateFromJson(userInfo);
    Navigator.of(context).pushReplacementNamed('/home');  }
}
