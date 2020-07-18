import 'package:ankev928/models/activity.dart';
import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/services/news_article_list_service.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:ankev928/services/user_info_service.dart';

import 'news/get_news_articles.dart';

GetIt getIt = GetIt.instance;

class LoadingPage extends StatefulWidget {
  static _LoadingPageState of(BuildContext context) =>
      context.ancestorStateOfType(const TypeMatcher<_LoadingPageState>());

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final UserInfoService _userInfoService = getIt.get<UserInfoService>();
  final NewsArticleListService _newsArticleListService =
      getIt.get<NewsArticleListService>();
  final ActivityListService _activityListService =
      getIt.get<ActivityListService>();

  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Image(image: AssetImage("assets/img/protologo.png"), fit: BoxFit.cover,);
      await _userInfoService.readFromSharedPrefs();
      getCurrentNewsArticles();
      getCurrentActivities();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible( fit: FlexFit.tight, child:  Padding(
              padding: EdgeInsets.all(16),
              child: Image(image: AssetImage("assets/img/protologo.png"), fit: BoxFit.contain,)),
          )
        ],
      ),
      ),
     );
  }

  void getCurrentNewsArticles() async {
    List<NewsArticle> _currentNewsArticles = await getNewsArticles();
    _newsArticleListService.update(_currentNewsArticles);
  }

  void getCurrentActivities() async {
    if (_userInfoService.current.isLoggedIn) {
      _activityListService.doAuthorizedActivityCall();
    } else {
      _activityListService.doUnAuthorizedActivityCall();
    }


  }
}
