import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:ankev928/models/activity.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/pages/calendar/activity_list_view.dart';

import 'package:ankev928/shared/textstyle.dart';



class CalendarMonthViewPage extends StatefulWidget {
  final Future<List<Activity>> _futureActivity;

  CalendarMonthViewPage(this._futureActivity);

  @override
  _CalendarPageState createState() => _CalendarPageState(this._futureActivity);
}

class _CalendarPageState extends State<CalendarMonthViewPage> {
  CalendarController _controller;
  Future<List<Activity>> _futureActivity;
  List<dynamic> _selectedEvents;

  _CalendarPageState(this._futureActivity);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _selectedEvents = [];
   _futureActivity = widget._futureActivity;
    //_futureActivity = getActivities();
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map){
    Map<String, dynamic> newMap ={};
    map.forEach((key,value){
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map){
    Map<DateTime, dynamic> newMap= {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _futureActivity,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  events: convertToCalenderEvents(snapshot),
                  availableCalendarFormats: const{
                    CalendarFormat.month: 'month'
                  },
                  calendarStyle: _calendarStyle(context),
                  daysOfWeekStyle: _daysOfWeekStyle(),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    titleTextStyle: usedTextStyle(Colors.black, header: true),
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarController: _controller,
                  onDaySelected: (date, events){
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  onCalendarCreated: (first, last, format) {
                  },
                  builders: CalendarBuilders(
                      selectedDayBuilder: (context, date, events) =>
                          Container(
                              margin: const EdgeInsets.all(4.2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Text( date.day.toString(), style: usedTextStyle(Colors.white)))
                  ),
                ),
                ..._selectedEvents.map((event) => ActivityListView(event)
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

CalendarStyle _calendarStyle (BuildContext context){
  return new CalendarStyle(
    todayColor: Color.fromRGBO(131, 183, 26, 0.5),
    todayStyle:  usedTextStyle(Colors.white),
    weekendStyle:  usedTextStyle(Colors.black),
    holidayStyle: usedTextStyle(Colors.black),
    // outsideDaysVisible: false,
    outsideStyle: usedTextStyle(Colors.black12),
    outsideWeekendStyle: usedTextStyle(Colors.black12),
  );
}

DaysOfWeekStyle _daysOfWeekStyle(){
  return new DaysOfWeekStyle(
      weekendStyle: usedTextStyle(Colors.black)
  );
}

Map<DateTime, List<dynamic>> convertToCalenderEvents(AsyncSnapshot snapshot) {
  Map<DateTime, List<dynamic>> newMap = {};
  if(snapshot.data != null){
    for(var activity in snapshot.data){
      var date = activity.startDate;
      var activityDate = stripTimeFromDateTime(date);
      if (newMap.containsKey(activityDate)){
        newMap[activityDate].add(activity);
      } else {
        newMap[activityDate] = [activity];
      }
    }
  }
  return newMap;
}

DateTime stripTimeFromDateTime(DateTime date) {
  final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
  final String formatted = serverFormater.format(date);
  final DateTime onlyDate = DateTime.parse(formatted);
  return onlyDate;
}


TextStyle usedTextStyle(Color color, {bool header = false}){
  double size;
  if(header){
     size = 20.0;
  } else {
    size = 14.0;
  }
  return new TextStyle(
  color: color,
  fontFamily: 'Poppins',
  fontSize: size
  );
}