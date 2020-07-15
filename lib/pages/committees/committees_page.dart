
import 'package:ankev928/pages/committees/committee_list_tile.dart';
import 'package:ankev928/pages/news/article_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

import 'package:ankev928/pages/committees/get_committees.dart';




class CommitteesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto Committees'),
        ),
        drawer: DefaultDrawer(),
        body: FutureBuilder(
          future: getCommittees(),
          builder: (BuildContext context, AsyncSnapshot snap){
            return  ListView.builder(
                itemCount: getLengthOfData(snap),
                itemBuilder: (BuildContext context, int index){
                  return new CommitteeListTile(snap.data[index]);
                }
            );
          },
        )
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
