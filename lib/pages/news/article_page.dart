import 'package:ankev928/pages/news/article_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:ankev928/models/news_article.dart';

import '../../shared/shared_detailpage.dart';

class ArticlePage extends StatelessWidget {
  final NewsArticle _newsArticle;

  ArticlePage(this._newsArticle);

  @override
  Widget build(BuildContext context) {
    Widget _getContent() {
      return new ListView(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
          children: <Widget>[
            new Container(
                child: new Stack(children: <Widget>[
              getBackground(context, _newsArticle.imgUrl),
              getGradient(context),
              new Column(children: <Widget>[
                new ArticleListView(_newsArticle, horizontal: false),
                new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 32.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          markdown( _newsArticle.content)
                        ]))
              ])
            , getToolbar(context)]),

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