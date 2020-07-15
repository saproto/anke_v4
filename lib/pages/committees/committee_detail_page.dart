import 'package:ankev928/models/comittee.dart';
import 'package:ankev928/pages/committees/committee_list_tile.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ankev928/shared/styling/shared_detailpage.dart';

class CommitteePage extends StatelessWidget {
  final Committee _committee;

  CommitteePage(this._committee);

  @override
  Widget build(BuildContext context) {
    List<Row> _getMembersList() {
      List<Row> membersList = [];
      for (var member in _committee.members) {
        membersList.add(new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 40)),
            CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(member.photo)),
            new Padding(padding: EdgeInsets.fromLTRB(0, 5, 10, 5)),
            Flexible(
              fit: FlexFit.loose,
              child: new Column(
           //     mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                      member.name,
                      style: Style.subHeaderTextStyle,
                  ),

                    Text(
                      '${member.role}, ${_getCorrectFormatDate(member.memberSince)}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,

                  ),
                ],
              ),
            )
          ],
        ));
      }
      return membersList;
    }

    Column _getMembers() {
      return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(10)),
          Text(
            "MEMBERS",
            style: Style.headerTextStyle,
          ),
          Separator(),
          ..._getMembersList(),
        ],
      );
    }

    Widget _getContent() {
      return new ListView(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
          children: <Widget>[
            new Container(
              child: new Stack(children: <Widget>[
                getBackground(context, _committee.photo),
                getGradient(context),
                new Column(children: <Widget>[
                  new CommitteeListTile(_committee, horizontal: false),
                  new Container(
                      padding: new EdgeInsets.symmetric(horizontal: 32.0),
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "DESCRIPTION",
                              style: Style.headerTextStyle,
                            ),
                            Separator(),
                            Text(_committee.description),
                            _getMembers(),
                          ]))
                ]),
                getToolbar(context)
              ]),
            )
          ]);
    }

    return Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
          constraints: new BoxConstraints.expand(),
          child: new Stack(
            children: <Widget>[
              _getContent(),
            ],
          )),
    );
  }
}

String _getCorrectFormatDate(DateTime date) {
  var formatDate = new DateFormat('d MMM yyyy');
  return formatDate.format(date);
}
