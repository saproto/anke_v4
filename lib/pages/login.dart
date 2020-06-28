import 'package:flutter/material.dart';

import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:ankev928/services/user_info_service.dart';

import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;


class LoginHandler extends StatefulWidget {
  static _LoginHandlerState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoginHandlerState>());

  @override
  _LoginHandlerState createState() => new _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => login(_userInfoService));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Login'),
        ),
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

  void login(UserInfoService _userInfoService) async {
    Map<String, dynamic> userInfo = await requestApiCallResult('user/info');
    _userInfoService.updateFromJson(userInfo);
    Navigator.of(context).pushReplacementNamed('/home');  }
}
