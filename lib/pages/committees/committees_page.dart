import 'package:ankev928/models/comittee.dart';
import 'package:ankev928/pages/committees/committee_list_tile.dart';
import 'package:ankev928/services/user_info_service.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

import 'package:ankev928/pages/committees/get_committees.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

class CommitteesPage extends StatelessWidget {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Committees', style: Style.headerPageTextStyle),
        ),
        drawer: DefaultDrawer(),
        body: StreamBuilder(
            stream: _userInfoService.stream$,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Future<List<Committee>> committeeList;
              if (snapshot.hasData && snapshot.data.isLoggedIn) {
                committeeList = getCommittees('committees');
              } else {
                //  committeeList = getCommittees('committees');
                committeeList = getCommittees(
                    'committees/unauthenticated', noAuthPresentOk: true);
              }
              return FutureBuilder(
                  future: committeeList,
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      return ListView.builder(
                          itemCount: getLengthOfData(snap),
                          itemBuilder: (BuildContext context, int index) {
                            return new CommitteeListTile(snap.data[index], userIsLoggedIn:  snapshot.data.isLoggedIn,);
                          });
                    } else {
                      return new Center(
                        child: Text("Loading committees"),
                      );
                    }
                  });
            })
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
