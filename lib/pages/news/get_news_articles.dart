import 'package:ankev928/models/news_article.dart';
import 'package:ankev928/shared/api_call.dart';

Future<List<NewsArticle>> getNewsArticles() async {
  List<dynamic> articleInfo =
  await requestApiCallResult('news');
  List<NewsArticle> articles = [];
  for (var i in articleInfo) {
    DateTime publishDate = DateTime.fromMillisecondsSinceEpoch(i["published_at"] * 1000);

    NewsArticle article = NewsArticle(
      id: i["id"],
      title: i["title"],
      imgUrl: i["featured_image_url"],
      content: i["content"],
      publishDate: publishDate,
    );
    articles.add(article);
  }

  return articles;
}
