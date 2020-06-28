import 'package:ankev928/models/activity.dart';
import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/pages/calendar/get_activities.dart';
import 'package:ankev928/services/activity_list_service.dart';
import 'package:ankev928/services/news_article_list_service.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
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
  final NewsArticleListService _newsArticleListService = getIt.get<NewsArticleListService>();
  final ActivityListService _activityListService = getIt.get<ActivityListService>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_){
          checkCredentials(_userInfoService);
          getCurrentNewsArticles();
          getCurrentActivities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Image.asset("assets/img/protologo.png"),
        ],
      ),
    ));
  }

  void checkCredentials(UserInfoService _userInfoService) async {
    bool hasCredentials = await checkForCredentials();

    if (hasCredentials) {
      Map<String, dynamic> userInfo = await requestApiCallResult('user/info');
      _userInfoService.updateFromJson(userInfo);
    } else {
      _userInfoService.resetAndWriteToSharedPrefs();
    }

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
  }

  void getCurrentNewsArticles() async {
    List<NewsArticle> _currentNewsArticles = await getNewsArticles();
    _newsArticleListService.update(_currentNewsArticles);
  }

  void getCurrentActivities() async{
    List<Activity> _currentActivities = await getActivities();
    _activityListService.update(_currentActivities);
    print("after update");
  }
}
