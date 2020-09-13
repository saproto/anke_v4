import 'package:ankev928/models/activity.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:ankev928/shared/styling/show_information_widget.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

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
          title: Text('S.A. Proto', style: Style.headerPageTextStyle),
        ),
        drawer: DefaultDrawer(),
        body:
          Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        showInformationOnScreen('Logging you out of Proto...'),
        Flexible( fit: FlexFit.tight, child:  Padding(
            padding: EdgeInsets.all(16),
            child: Image(image: AssetImage("assets/img/protologo.png"), fit: BoxFit.contain,)),
        )
      ],
    ),
        );
  }

  void logout() async {
    logOutUser();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
  }
}
