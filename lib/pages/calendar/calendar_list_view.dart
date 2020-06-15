import 'package:ankev928/pages/calendar/activity_list_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/models/activity.dart';



class CalendarListViewPage extends StatelessWidget{
  Future<List<Activity>> _futureActivity;
  CalendarListViewPage(Future<List<Activity>> _activities){
    _futureActivity = _activities;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _futureActivity,
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


//class _ListPageState extends State<CalendarListViewPage> {
//  Future<List<Activity>> _futureActivity;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _futureActivity = getActivities();
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: FutureBuilder(
//          future: _futureActivity,
//          builder: (BuildContext context, AsyncSnapshot snapshot) {
//            return ListView.builder(
//              itemCount: getLengthOfData(snapshot),
//                itemBuilder: (BuildContext context, int index){
//                print("hallo");
//                  return new ActivityListView(snapshot.data[index]);
//                }
//            );
//          },
//        ),
//    );
//  }
//
//}

int getLengthOfData(AsyncSnapshot snapshot){
  if(snapshot.data != null){
    return snapshot.data.length;
  } else {
    return 0;
  }
}

