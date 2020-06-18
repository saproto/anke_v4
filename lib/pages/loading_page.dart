import 'package:ankev928/shared/api_call.dart';
import 'package:flutter/material.dart';

import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/models/user_info.dart';

class LoadingPage extends StatefulWidget {
  static _LoadingPageState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoadingPageState>());

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkCredentials());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
//                Text(
//                  'loading page',
//                  style: TextStyle(fontSize: 35),
//                )
//              ],
            children: <Widget>[
              new Image.asset("assets/img/protologo.png"),
            ],
          ),
        ));
  }

  void checkCredentials() async {

    bool hasCredentials = await checkForCredentials();

    if(hasCredentials){
      Map<String, dynamic> userInfo = await requestApiCallResult('user/info');
      UserInfoInheritedWidget.of(context).userInfo.updateFromJson(userInfo);
    } else {
      UserInfoInheritedWidget.of(context).userInfo.resetInternalUserInfo();
    }
    Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
  }
}
