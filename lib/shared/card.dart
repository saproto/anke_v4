import 'package:flutter/material.dart';
import 'package:ankev928/shared/separator.dart';
import 'package:ankev928/shared/textstyle.dart';


Container cardLayout(bool horizontal, Container content, double height) {
  return new Container(
    child: content,
    height: height,
    margin: horizontal
        ? new EdgeInsets.only(left: 0)
        : new EdgeInsets.only(top: 144.0),
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

Widget getHeader(String header) {
  return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Separator(),
        new Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: new Text(
            header,
            style: Style.headerTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Separator(),
      ]);
}