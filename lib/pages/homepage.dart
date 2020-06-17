import 'package:ankev928/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/shared/separator.dart';
import 'package:ankev928/shared/card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Future didChangeDependencies() async {
    super.didChangeDependencies();
    await UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getAttributesFromSharedPrefs();
    setState(() {});
  }

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
                                  headerCardContent(
                                    context,
                                  )
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

Container headerCardContent(BuildContext context) {
  return new Container(
      child: new Padding(
        padding: EdgeInsets.only(top: 50),
        child: new Align(
          alignment: Alignment.center,
          child: welcomeMessage(context),
        ),
      ));
}


Column welcomeMessage(BuildContext context) {
  Text line1;
  Text line2;
  if (UserInfoInheritedWidget
      .of(context)
      .userInfo
      .getUserAttribute('is_logged_in')) {
    String name = UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getUserAttribute('display_name');
    String welcomeMessage = UserInfoInheritedWidget
        .of(context)
        .userInfo
        .getUserAttribute('welcome_message');
    line1 = new Text("Hi $name,", style: Style.headerHomePageTextStyle,
      textAlign: TextAlign.center,);
    line2 = new Text("$welcomeMessage", style: Style.headerHomePageTextStyle,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2);
  } else {
    line1 = new Text("Welcome to the app of S.A Proto",
      style: Style.headerHomePageTextStyle,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,);
    line2 = new Text("Log in to unlock more features", style: Style.headerHomePageTextStyle.copyWith(fontSize: 18.0),
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
        return new block();
      });
}

class block extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      //height: 150,
      width: 150,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        border: Border.all(color: Color(0xff6c757d), width: 0.5),
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }
}
//
//
