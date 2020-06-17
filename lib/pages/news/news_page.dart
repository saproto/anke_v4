import 'package:ankev928/pages/calendar/calendar_list_view.dart';
import 'package:ankev928/pages/news/article_list_view.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

import 'package:ankev928/pages/news/get_news_articles.dart';



class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto News'),
        ),
        drawer: DefaultDrawer(),
        body: FutureBuilder(
          future: getNewsArticles(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            return ListView.builder(
                itemCount: getLengthOfData(snapshot),
                itemBuilder: (BuildContext context, int index){
                  return new ArticleListView(snapshot.data[index]);
                }
            );
          },
        ),
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
