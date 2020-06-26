import 'package:ankev928/shared/api_call.dart';
import 'package:flutter/material.dart';

import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/models/user_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get_it/get_it.dart';
import 'package:ankev928/services/user_info_service.dart';

GetIt getIt = GetIt.instance;

class LoadingPage extends StatefulWidget {
  static _LoadingPageState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoadingPageState>());

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => checkCredentials(_userInfoService));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.asset("assets/img/protologo.png"),
        ],
      ),
    ));
  }

  void checkCredentials(UserInfoService _userInfoService) async {
    bool hasCredentials = await checkForCredentials();

    if (hasCredentials) {
      Map<String, dynamic> userInfo = await requestApiCallResult('user/info');
      _userInfoService.updateFromJson(userInfo);
    } else {
      _userInfoService.resetAndWriteToSharedPrefs();
    }

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
  }
}
