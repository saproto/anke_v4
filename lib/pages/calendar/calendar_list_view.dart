import 'package:ankev928/pages/calendar/activity_list_view.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/models/activity.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;



class CalendarListViewPage extends StatelessWidget{
  final ActivityListService _activityListService = getIt.get<ActivityListService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _activityListService.stream$,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: getLengthOfData(snapshot),
              itemBuilder: (BuildContext context, int index){
                print("hallo");
                return new ActivityListView(snapshot.data[index]);
              }
          );
        },
      ),
    );
  }
}

int getLengthOfData(AsyncSnapshot snapshot){
  if(snapshot.data != null){
    return snapshot.data.length;
  } else {
    return 0;
  }
}

