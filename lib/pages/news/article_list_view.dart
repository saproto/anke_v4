import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/shared/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:ankev928/pages/news/article_page.dart';

import 'package:ankev928/shared/textstyle.dart';
import 'package:ankev928/shared/separator.dart';
import 'package:intl/intl.dart';

class ArticleListView extends StatelessWidget {
  final NewsArticle newsArticle;
  final bool horizontal;

  ArticleListView(this.newsArticle, {this.horizontal = true});

  ArticleListView.vertical(this.newsArticle) : horizontal = false;

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
                  newsArticle.title,
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
                    "Published on: " +
                        _getCorrectFormatDate(newsArticle.publishDate),
                    style: Style.regularTextStyle),
              ),
           // ],
        //  )
        ],
      ),
    );

    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new ArticlePage(newsArticle),
              ))
          : null,
      child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              cardLayout(horizontal, articleCardContent, 130.0)
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
