import 'package:flutter/material.dart';


import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';


Widget getTitle(String header) {
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