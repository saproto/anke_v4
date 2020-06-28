import 'package:ankev928/pages/calendar/activity_list_view.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:flutter/material.dart';


import 'package:ankev928/shared/functions.dart';
import '../../shared/card.dart';
import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/models/activity.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class CalendarMyActivitiesViewPage extends StatefulWidget {
  CalendarMyActivitiesViewPage();

  @override
  _CalendarMyActivitiesViewPageState createState() =>
      _CalendarMyActivitiesViewPageState();
}

class _CalendarMyActivitiesViewPageState
    extends State<CalendarMyActivitiesViewPage> {
  final ActivityListService _activityListService =
      getIt.get<ActivityListService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: StreamBuilder(
          stream: _activityListService.stream$,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Activity> attending = attendingActivities(snapshot);
            List<Activity> organizing = organizingActivities(snapshot);
            List<Activity> helping = helpingActivities(snapshot);
            List<Activity> isBackUp = isBackUpActivities(snapshot);
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
                  isBackUp.length > 0 ? getHeader("On backup list") : null,
                  ...isBackUp.map((event) => ActivityListView(event)),
                ].where(notNull).toList(),
              );
            }
          },
        ),
      ),
    );
  }
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

List<Activity> isBackUpActivities(AsyncSnapshot snapshot) {
  List<Activity> backUpActivities = [];
  if (snapshot.data != null) {
    for (var activity in snapshot.data) {
      if (activity.userHasSignedUpBackUp != null && activity.userHasSignedUpBackUp) {
        backUpActivities.add(activity);
      }
    }
  }
  return backUpActivities;
}
