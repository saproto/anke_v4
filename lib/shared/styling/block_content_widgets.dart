import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';

Container blockContentWidgets({String title, String icon, String secondText, String thirdText = ""}) {
  return Container(
    margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
    child: new Column(
      children: <Widget>[
        Flexible(
            flex: 2,
            child: Text(title,
                style:
                    Style.headerTextStyle.copyWith(color: Color(0xff6c757d)))),
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: new Container(
              height: 1.0,
            )),
        Flexible(
          flex: 4,
          child: Image(
            image: AssetImage(icon),
          ),
        ),
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: new Container(
              height: 1.0,
            )),
        Flexible(
            flex: 3,
            child: Text(
              secondText,
               // overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                maxLines: 2
            )),
//        Flexible(
//            flex: 2,
//            child: Text(
//                thirdText,
//                overflow: TextOverflow.fade,
//                textAlign: TextAlign.center,
//                maxLines: 1
//            )),
      ],
    ),
  );
}
