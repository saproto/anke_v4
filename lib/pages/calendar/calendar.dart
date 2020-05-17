import 'package:ankev928/models/user_info.dart';
import 'package:ankev928/models/activity.dart';

import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/api_call.dart';

import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => decodeActvities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S.A. Proto Events'),
      ),
      drawer: DefaultDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'These are some events!' +
                  (UserInfoInheritedWidget.of(context)
                          .userInfo
                          .getUserAttribute('display_name') ??
                      'go to login' + '!'),
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(onPressed: () {
              decodeActvities();
            })
          ],
        ),
      ),
    );
  }

  void getActivities() async {

  }

  Future<List<Activity>> decodeActvities() async{
    List<dynamic> calenderInfo =
    await requestApiCallResult('events/upcoming/for_user');
    List<Activity> activities = [];
    for(var i in calenderInfo){
      DateTime startDate = DateTime.fromMillisecondsSinceEpoch(i["start"]* 1000);
      DateTime endDate = DateTime.fromMillisecondsSinceEpoch(i["end"]* 1000);
      Activity activity = Activity(i["id"],i["title"], i["description"], startDate, endDate, i["location"]);
      activities.add(activity);
      print(activity.title);
    }

    return  activities;
  }
}
