

import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


Container blockContent({String title, DateTime date, int maxlines = 2}){
  return new Container(
      margin: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Text(
              title,
              style: Style.headerTextStyle.copyWith(color: Color(0xff6c757d)),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: maxlines,
            ),
          ),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Separator(),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Flexible(
            flex: 1,
              child: Text(
              _getCorrectFormatDate(date),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              maxLines: maxlines,
            ),
          ),
        ],
      ));

}

String _getCorrectFormatDate(DateTime date) {
  var formatDate = new DateFormat('EEE, d MMM yyyy');
  return formatDate.format(date);
}
