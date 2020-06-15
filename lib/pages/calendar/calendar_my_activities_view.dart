import 'package:ankev928/pages/calendar/activity_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/shared/functions.dart';
import 'separator.dart';
import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/models/activity.dart';

class CalendarMyActivitiesViewPage extends StatelessWidget {
  final Future<List<Activity>> _futureActivity;

  CalendarMyActivitiesViewPage(this._futureActivity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: FutureBuilder(
          future: _futureActivity,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Activity> attending = attendingActivities(snapshot);
            List<Activity> organizing = organizingActivities(snapshot);
            List<Activity> helping = helpingActivities(snapshot);
            if (attending.length == 0 &&
                organizing.length == 0 &&
                helping.length == 0) {
              return new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                      child: Text(
                        "You are not going to any activities.",
                        style: Style.headerTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]);
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  attending.length > 0 ? getHeader("Participating") : null,
                  ...attending.map((event) => ActivityListView(event)),
                  organizing.length > 0 ? getHeader("Organizing") : null,
                  ...organizing.map((event) => ActivityListView(event)),
                  helping.length > 0 ? getHeader("Helping") : null,
                  ...helping.map((event) => ActivityListView(event)),
                ].where(notNull).toList(),
              );
            }
          },
        ),
      ),
    );
  }
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

int getLengthOfData(AsyncSnapshot snapshot) {
  if (snapshot.data != null) {
    return snapshot.data.length;
  } else {
    return 0;
  }
}

List<Activity> attendingActivities(AsyncSnapshot snapshot) {
  List<Activity> goingActivities = [];
  if (snapshot.data != null) {
    for (var activity in snapshot.data) {
      if (activity.hasSignUp && activity.userHasSignedUp) {
        goingActivities.add(activity);
      }
    }
  }
  return goingActivities;
}

List<Activity> organizingActivities(AsyncSnapshot snapshot) {
  List<Activity> orgActivities = [];
  if (snapshot.data != null) {
    for (var activity in snapshot.data) {
      if (activity.isOrganizing) {
        orgActivities.add(activity);
      }
    }
  }
  return orgActivities;
}

List<Activity> helpingActivities(AsyncSnapshot snapshot) {
  List<Activity> helpActivities = [];
  if (snapshot.data != null) {
    for (var activity in snapshot.data) {
      if (activity.isHelping != null && activity.isHelping) {
        helpActivities.add(activity);
      }
    }
  }
  return helpActivities;
}
