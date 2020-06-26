import 'package:ankev928/shared/api_call.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/models/user_info.dart';

import 'package:get_it/get_it.dart';
import 'package:ankev928/services/user_info_service.dart';

GetIt getIt = GetIt.instance;

class LogoutHandler extends StatefulWidget {
  static _LogoutHandler of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LogoutHandler>());

  @override
  _LogoutHandler createState() => new _LogoutHandler();
}

class _LogoutHandler extends State<LogoutHandler> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => logout(_userInfoService));
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

  void logout(UserInfoService _userInfoService) async {
    revokeTokens();
    await _userInfoService.resetAndWriteToSharedPrefs();
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
