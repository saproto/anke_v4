import 'package:ankev928/pages/homepage/widgets_homepage.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/services/user_info_service.dart';

import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';
import 'package:ankev928/shared/styling/title_style.dart';
import 'package:ankev928/shared/styling/block.dart';

import 'package:ankev928/pages/homepage/header_homepage.dart';
import 'package:ankev928/pages/homepage/calender_widget.dart';
import 'package:ankev928/pages/homepage/news_widget.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class HomePage extends StatelessWidget {
  final ActivityListService _activityListService =
      getIt.get<ActivityListService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto', style: Style.headerPageTextStyle),
        ),
        drawer: DefaultDrawer(),
        body: RefreshIndicator(
            onRefresh: _activityListService.refresh,
            child: new SingleChildScrollView(
                child: new Container(
                    child: new Stack(
              children: <Widget>[
                new Padding(
                    padding: new EdgeInsets.only(top: 10),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        HeaderHomePage(),
                        getTitle("Upcoming activities"),
                        new Container(
                          height: 180.0,
                          width: MediaQuery.of(context).size.width,
                          child: CalendarWidgets(),
                        ),
                        getTitle("Widgets"),
                        new Container(
                            height: 180.0,
                            width: MediaQuery.of(context).size.width,
                            child: WidgetsHomePage()),
                        getTitle("News"),
                        new Container(
                            height: 180.0,
                            width: MediaQuery.of(context).size.width,
                            child: NewsWidget()),
                      ],
                    ))
              ],
            )))));
  }
}

ListView listView(String text) {
  return new ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return block(new Container());
      });
}
