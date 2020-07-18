import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/shared/styling/card_autoHeight.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:ankev928/models/activity.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ankev928/pages/calendar/activity_detailpage.dart';

class ActivityListTile extends StatelessWidget {
  final Activity activity;
  final bool horizontal;

  ActivityListTile(this.activity, {this.horizontal = true});
  ActivityListTile.vertical(this.activity) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final activityCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            activity.title,
            style: Style.headerTextStyle,
            textAlign: horizontal ? TextAlign.left : TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: horizontal ? 2 : 10,
          ),
          new Container(
            height: 2.0,
          ),
          Separator(),
          new Container(
            height: 2.0,
          ),
          new Container(
              child: _activityValue(
                  value: _getCorrectFormatDate(
                      activity.startDate, activity.endDate),
                  image: "assets/img/clock.png")),
          new Container(
            height: 2.0,
          ),
          new Container(
            child: _activityValue(
                value: activity.location, image: "assets/img/location.png"),
          )
        ],
      ),
    );


    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context)
              .push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ActivityDetailPage(activity.id),
              ) ) : null,
      child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              horizontal ?  cardLayout(horizontal, activityCardContent, 154.0) :
              cardLayoutAutoHeight(horizontal, activityCardContent),
              //activityThumbNail,
            ],
          )),
    );
  }
}

Widget _activityValue({String value, String image}) {
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

String _getCorrectFormatDate(DateTime startDate, DateTime endTime) {
  var formatStartDate = new DateFormat('EEE, d MMM  HH:mm - ');
  var formatEndDate = null;
  if (stripTimeFromDateTime(startDate)
          .compareTo(stripTimeFromDateTime(endTime)) !=
      0) {
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
