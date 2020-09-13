import 'package:ankev928/services/user_info_service.dart';
import 'package:ankev928/shared/styling/show_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ankev928/pages/calendar/activity_list_tile.dart';
import 'package:ankev928/services/activity_list_service.dart';

import 'package:ankev928/shared/helpers/functions.dart';
import 'package:ankev928/shared/styling/title_style.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:ankev928/models/activity.dart';

GetIt getIt = GetIt.instance;

class CalendarMyActivitiesViewPage extends StatelessWidget {
  final ActivityListService _activityListService =
  getIt.get<ActivityListService>();
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: StreamBuilder(
            stream: _userInfoService.stream$,
            builder: (BuildContext context, AsyncSnapshot snap) {
              if(snap.hasData) {
                if(snap.data.isLoggedIn) {
                  return StreamBuilder(
                    stream: _activityListService.stream$,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Activity> attending = attendingActivities(snapshot);
                      List<Activity> organizing = organizingActivities(
                          snapshot);
                      List<Activity> helping = helpingActivities(snapshot);
                      List<Activity> isBackUp = isBackUpActivities(snapshot);
                      if (attending.length == 0 &&
                          organizing.length == 0 &&
                          helping.length == 0) {
                        return new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              showInformationOnScreen("You are not going to any activities."),
//                              new Padding(
//                                padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
//                                child: Text(
//                                  "You are not going to any activities.",
//                                  style: Style.headerTextStyle,
//                                  textAlign: TextAlign.center,
//                                ),
//                              ),
                            ]);
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            attending.length > 0
                                ? getTitle("Participating")
                                : null,
                            ...attending.map((event) =>
                                ActivityListTile(event)),
                            organizing.length > 0
                                ? getTitle("Organizing")
                                : null,
                            ...organizing.map((event) =>
                                ActivityListTile(event)),
                            helping.length > 0 ? getTitle("Helping") : null,
                            ...helping.map((event) => ActivityListTile(event)),
                            isBackUp.length > 0
                                ? getTitle("On backup list")
                                : null,
                            ...isBackUp.map((event) => ActivityListTile(event)),
                          ].where(notNull).toList(),
                        );
                      }
                    },
                  );
                } else {
                  return  showInformationOnScreen("Sorry you are not logged in, please log in to use this function"
                  );
                }
              } else {
                return   showInformationOnScreen("Loading activities");
              }
            },
          )
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
      if (activity.isOrganizing != null && activity.isOrganizing) {
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
      if (activity.userHasSignedUpBackUp != null &&
          activity.userHasSignedUpBackUp) {
        backUpActivities.add(activity);
      }
    }
  }
  return backUpActivities;
}
