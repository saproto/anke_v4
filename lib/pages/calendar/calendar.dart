import 'package:ankev928/models/user_info.dart';
import 'package:ankev928/models/activity.dart';

import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/textstyle.dart';

import 'calendar_month_view.dart';
import 'calendar_list_view.dart';
import 'calendar_my_activities_view.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';

import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _currentIndex = 1;
  List<Widget> _children = [];
  Future<List<Activity>> _futureActivity;

  _setActivities(){
    setState(() {});
    _futureActivity = getActivities();
    _children = [
      CalendarListViewPage(_futureActivity),
      CalendarMonthViewPage(_futureActivity),
      CalendarMyActivitiesViewPage(_futureActivity)
    ];
  }


  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => decodeActvities());
    _setActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S.A. Proto Events', style: Style.headerPageTextStyle,),
      ),
      drawer: DefaultDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        //onTap: changeTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('list'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('my activities'),
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
