import 'package:ankev928/models/activity.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/shared/styling/show_information_widget.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:ankev928/services/user_info_service.dart';

import 'package:get_it/get_it.dart';

import 'calendar/get_activities.dart';

GetIt getIt = GetIt.instance;


class LoginHandler extends StatefulWidget {
  static _LoginHandlerState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoginHandlerState>());

  @override
  _LoginHandlerState createState() => new _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  final ActivityListService _activityListService =
  getIt.get<ActivityListService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => login(_userInfoService));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Login', style: Style.headerPageTextStyle),
        ),
        body:
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              showInformationOnScreen('Logging you into Proto...'),
              Flexible( fit: FlexFit.tight, child:  Padding(
               padding: EdgeInsets.all(16),
                child: Image(image: AssetImage("assets/img/protologo.png"), fit: BoxFit.contain,)),
              )
            ],
          ),
        );
  }

  void login(UserInfoService _userInfoService) async {
    Map<String, dynamic> userInfo = await doApiGetRequestAuthenticate('user/info');
    _userInfoService.updateFromJson(userInfo);
    _activityListService.doAuthorizedActivityCall();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false); }
}
