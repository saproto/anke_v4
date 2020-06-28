

import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/models/user_info.dart';
import 'package:rxdart/rxdart.dart';


class NewsArticleListService {

  BehaviorSubject _newsArticleList = BehaviorSubject.seeded(new List<NewsArticle>());

  Stream get stream$ => _newsArticleList.stream;
  List<NewsArticle> get current => _newsArticleList.value;

  update(List<NewsArticle> _updatedNewsArticleList){
    _newsArticleList.add(_updatedNewsArticleList);
  }
}