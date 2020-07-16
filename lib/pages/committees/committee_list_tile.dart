import 'package:ankev928/models/comittee.dart';
import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/pages/committees/committee_detail_page.dart';
import 'package:ankev928/shared/styling/card.dart';
import 'package:ankev928/shared/styling/card_autoHeight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:ankev928/pages/news/article_page.dart';

import 'package:ankev928/shared/styling/textstyle.dart';
import 'package:ankev928/shared/styling/separator.dart';
import 'package:intl/intl.dart';

class CommitteeListTile extends StatelessWidget {
  final Committee _committee;
  final bool horizontal;
  final bool userIsLoggedIn;

  CommitteeListTile(this._committee, {this.userIsLoggedIn, this.horizontal = true});

  CommitteeListTile.vertical(this._committee, this.userIsLoggedIn) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final articleCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
        horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          // Wrap(
          //   children: <Widget>[
          new Container(height: 4.0),
          Flexible(
            flex: 3,
            child: new Text(
              _committee.name,
              style: Style.headerTextStyle,
              textAlign: horizontal ? TextAlign.left : TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: horizontal ? 2 : 10,
            ),
          ),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Separator(),
          Flexible(
              flex: 0,
              fit: FlexFit.tight,
              child: new Container(
                height: 2.0,
              )),
          Flexible(
            flex: 1,
            child: new Text(
                _committee.email,
                style: Style.regularTextStyle),
          ),

        ],
      ),
    );

    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (_, __, ___) => new CommitteePage(_committee,  userIsLoggedIn)),
      )
          : null,
      child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              horizontal ? cardLayout(horizontal, articleCardContent, 130.0) :
              cardLayoutAutoHeight(horizontal, articleCardContent)
            ],
            //activityThumbNail,
          )),
    );
  }
}



String _getCorrectFormatDate(DateTime date) {
  var formatDate = new DateFormat('EEE, d MMM yyyy HH:mm ');
  return formatDate.format(date);
}
