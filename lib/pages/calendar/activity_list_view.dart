
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ankev928/models/activity.dart';

import 'package:ankev928/shared/textstyle.dart';
import 'separator.dart';
import 'activity_detailpage.dart';


class ActivityListView extends StatelessWidget {
final Activity activity;
final bool horizontal;

ActivityListView(this.activity, {this.horizontal = true});
ActivityListView.vertical(this.activity): horizontal = false;

@override
Widget build(BuildContext context) {

  final activityCardContent = new Container(
    margin: new EdgeInsets.fromLTRB(16.0, 16.0 , 16.0, 16.0) ,
    constraints: new BoxConstraints.expand(

    ),
    child: new Column(
      crossAxisAlignment:horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: <Widget>[

        new Container(height: 4.0),
        new Text(activity.title,
          style: Style.headerTextStyle, textAlign: horizontal ? TextAlign.left : TextAlign.center,
        ),
        new Container(height: 2.0,),
        Separator(),
        new Container(height: 2.0,),
        new Container(
            child: _activityValue(
                value: _getCorrectFormatDate(activity.startDate, activity.endDate),
                image: "assets/img/clock.png"
            )
        ),
        new Container(height: 2.0,),
        new Container(
          child: _activityValue(
              value: activity.location,
              image: "assets/img/location.png"
          ),
        )
      ],
    ),
  );

  final activityCard = new Container(
    child: activityCardContent,
    height: 154.0,
    margin: horizontal
        ? new EdgeInsets.only(left: 0)
        : new EdgeInsets.only(top: 144.0),
    decoration: new BoxDecoration(
      border: Border.all(
        color: Color(0xff6c757d),
        width: 0.5
      ),
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

  return new GestureDetector(
    onTap: horizontal ? () => Navigator.of(context).push(new PageRouteBuilder(
      pageBuilder: (_, __, ___) => new ActivityDetailPage(activity),
    )) : null,
    child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            activityCard,
            //activityThumbNail,
          ],
        )),
  );
}

}

Widget _activityValue({String value, String image}){

  return new Container(
    child: new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Image.asset(image, height: 12.0),
        new Container(width: 8.0),
        new Text(value, style: Style.regularTextStyle),
      ],
    ),
  );
}

String _getCorrectFormatDate(DateTime startDate, DateTime endTime){
  var formatStartDate = new DateFormat('EEE, d MMM  HH:mm - ');
  var formatEndDate= null;
  if (stripTimeFromDateTime(startDate).compareTo(stripTimeFromDateTime(endTime)) != 0){
    formatEndDate = new DateFormat('EEE, d MMM  HH:mm');
  } else {
    formatEndDate = new DateFormat('HH:mm');
  }
  return formatStartDate.format(startDate) + formatEndDate.format(endTime);
}


DateTime stripTimeFromDateTime(DateTime date) {
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final String formatted = serverFormater.format(date);
  final DateTime onlyDate = DateTime.parse(formatted);
  return onlyDate;
}