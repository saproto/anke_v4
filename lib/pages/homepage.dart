import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/shared/card.dart';
import 'package:ankev928/shared/block.dart';
import 'package:get_it/get_it.dart';
import 'package:ankev928/services/user_info_service.dart';


GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
//
//  @override
//  Future didChangeDependencies() async {
//    super.didChangeDependencies();
//    await _userInfoService.readFromSharedPrefs();
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto'),
        ),
        drawer: DefaultDrawer(),
        body: SingleChildScrollView(
            child: new Container(
                child: new Stack(
                  children: <Widget>[
                    new Padding(
                        padding: new EdgeInsets.only(top: 10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: new Stack(
                                children: <Widget>[
                                  cardLayout(
                                      true, headerCardContentBackGroundImage,
                                      154.0),
                                  StreamBuilder(
                                    stream: _userInfoService.stream$,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snap) {
                                        return headerCardContent(snap);
                                    },
                                  ),

                                ],
                              ),
                            ),
                            getHeader("Upcoming activities"),
                            new Container(
                              //padding: EdgeInsets.all(10),
                              height: 180.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: listView("dymmy"),
                            ),
                            getHeader("Widgets"),
                            new Container(
                                height: 180.0,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: listView("hpo, hoi hoi"))
                          ],
                        ))
                  ],
                ))));
  }
}

final headerCardContentBackGroundImage = new Container(
  decoration: BoxDecoration(
    borderRadius: new BorderRadius.circular(8.0),
    image: DecorationImage(
        fit: BoxFit.fitHeight,
        colorFilter:
        ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
        image: NetworkImage(
            "https://static.saproto.com/image/3574/6f2f9ad26326657cf5847069ca92bb3a5d86e78f")),
  ),
);

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
    String welcomeMessage = snap.data.welcomeMessage;
    line1 = new Text("Hi $name,", style: Style.headerWhiteTextStyle,
      textAlign: TextAlign.center,);
    line2 = new Text("$welcomeMessage", style: Style.headerWhiteTextStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2);
  } else {
    line1 = new Text("Welcome to the app of S.A Proto",
      style: Style.headerWhiteTextStyle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,);
    line2 = new Text("Log in to unlock more features",
      style: Style.headerWhiteTextStyle.copyWith(fontSize: 18.0),
      textAlign: TextAlign.center,);
  }
  return new Column(
    children: <Widget>[
      line1,
      line2
    ],

  );
}

ListView listView(String text) {
  return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return block(new Container());
      });
}


//
//
