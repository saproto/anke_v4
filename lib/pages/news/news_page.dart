
import 'package:ankev928/pages/news/article_list_view.dart';
import 'package:ankev928/services/news_article_list_service.dart';
import 'package:flutter/material.dart';
import 'package:ankev928/shared/drawer.dart';

import 'package:get_it/get_it.dart';


GetIt getIt = GetIt.instance;

class NewsPage extends StatelessWidget {

  final NewsArticleListService _newsArticleListService = getIt.get<NewsArticleListService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('S.A. Proto News'),
        ),
        drawer: DefaultDrawer(),
        body: StreamBuilder(
          stream: _newsArticleListService.stream$,
          builder: (BuildContext context, AsyncSnapshot snap){
            return  ListView.builder(
                itemCount: getLengthOfData(snap),
                itemBuilder: (BuildContext context, int index){
                  return new ArticleListView(snap.data[index]);
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
