

import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';

Widget showInformationOnScreen(String text){
  return   new Padding(
    padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
    child: Text(
      text,
      style: Style.headerTextStyle,
      textAlign: TextAlign.center,
    ),
  );
}