import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/services/user_info_service.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';


GetIt getIt = GetIt.instance;

class HeaderHomePage extends StatelessWidget {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: new GestureDetector(
        onTap: _userInfoService.current.isLoggedIn ? null :() => Navigator.of(context)
            .pushNamed('/login'),
        child: new Stack(
        children: <Widget>[
          cardLayout(true, headerCardContentBackGroundImage, 154.0),
          StreamBuilder(
            stream: _userInfoService.stream$,
            builder: (BuildContext context, AsyncSnapshot snap) {
              return headerCardContent(snap);
            },
          ),
        ],
      ),
      ),
    );
  }
}

final headerCardContentBackGroundImage = new Container(
  decoration: BoxDecoration(
    borderRadius: new BorderRadius.circular(8.0),
    image: DecorationImage(
        fit: BoxFit.fill,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
        image: NetworkImage(
            "https://static.saproto.com/image/3574/6f2f9ad26326657cf5847069ca92bb3a5d86e78f")),
  ),
);
//
//BoxFit getFit(){
//  if()
//  return null;
//}
Container headerCardContent(AsyncSnapshot snap) {
  return new Container(
      child: new Padding(
    padding: EdgeInsets.only(top: 50),
    child: new Align(
      alignment: Alignment.center,
      child: welcomeMessage(snap),
    ),
  ));
}

Column welcomeMessage(AsyncSnapshot snap) {
  Text line1;
  Text line2;
  if (snap.hasData && snap.data.isLoggedIn) {
    String name = snap.data.displayName;
    String welcomeMessage = snap.data.welcomeMessage == null ? "Nice to see you back!" : snap.data.welcomeMessage;
    line1 = new Text(
      "Hi $name,",
      style: Style.headerWhiteTextStyle,
      textAlign: TextAlign.center,
    );
    line2 = new Text("$welcomeMessage",
        style: Style.headerWhiteTextStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2);
  } else {
    line1 = new Text(
      "Welcome to the app of S.A. Proto",
      style: Style.headerWhiteTextStyle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
    line2 = new Text(
      "Log in to unlock more features",
      style: Style.headerWhiteTextStyle.copyWith(fontSize: 18.0),
      textAlign: TextAlign.center,
    );
  }
  return new Column(
    children: <Widget>[line1, line2],
  );
}
