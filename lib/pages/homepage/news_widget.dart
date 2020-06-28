import 'package:ankev928/pages/news/article_page.dart';
import 'package:ankev928/services/news_article_list_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ankev928/shared/styling/block_content.dart';
import 'package:ankev928/shared/styling/block.dart';



import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;


class NewsWidget extends StatelessWidget {

  final NewsArticleListService _newsArticleListService = getIt.get<NewsArticleListService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _newsArticleListService.stream$,
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.data != null) {
          return new ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snap.data.length > 5 ? 5 : snap.data.length,
            itemBuilder: (BuildContext context, int index) {
              return  new GestureDetector(
                  onTap: (() {Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (_, __, ___) => new ArticlePage(snap.data[index])));}),
                  child: block(blockContent(
                      title:snap.data[index].title,
                      date: snap.data[index].publishDate,
                      maxlines: 3))
              );
            },
          );
        } else {
          return Text("loading");
        }
      },
    );
  }

}
