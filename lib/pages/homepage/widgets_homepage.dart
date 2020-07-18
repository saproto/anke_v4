import 'package:ankev928/services/user_info_service.dart';
import 'package:ankev928/shared/styling/block.dart';
import 'package:ankev928/shared/styling/block_content_widgets.dart';
import 'package:ankev928/shared/styling/flushbar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/pages/homepage/is_alfred_there.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class WidgetsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        isAlfredThereGestureDetector(context),
        onmomcomScanner(context),
        addQuoteToQuoteCorner(context),
      ],
    );
  }
}

GestureDetector isAlfredThereGestureDetector(BuildContext context) {
  return new GestureDetector(
    onTap: (() {
      String message = "What do you want us to do? Summon Alfred?";
      getFlushbar(context, message, 5,  Theme.of(context).primaryColor, );
    }),
    child: IsAlfredThere(),
  );
}

GestureDetector onmomcomScanner(BuildContext context) {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  return new GestureDetector(
      onTap: (() {
        if (_userInfoService.current.isLoggedIn) {
          Navigator.of(context).pushNamed('/qrscanner');
        } else {
          String message =  "You need to be logged in to use this function. Please go to login!";
          getFlushbar(context, message, 5,  Theme.of(context).primaryColor, );
        }
      }),
      child: Opacity(
          opacity: _userInfoService.current.isLoggedIn ? 1.0 : 0.6,
          child: block(blockContentWidgets(
              title: "Omnomcom",
              icon: "assets/img/qrscanner.png",
              secondText: "scanner"))));
}

GestureDetector addQuoteToQuoteCorner(BuildContext context) {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  return new GestureDetector(
    onTap: (() {
      if (_userInfoService.current.isLoggedIn) {
        Navigator.of(context).pushNamed('/addQuote');
      } else {
        String message =  "You need to be logged in to use this function. Please go to login!";
        getFlushbar(context, message, 5,  Theme.of(context).primaryColor, );

      }
    }),
    child: Opacity(
      opacity: _userInfoService.current.isLoggedIn ? 1.0 : 0.6,
      child: block(
        blockContentWidgets(
            title: "Quotes",
            icon: "assets/img/quotes.png",
            secondText: "add quote"),
      ),
    ),
  );
}
