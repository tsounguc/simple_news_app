import 'package:simple_news_app/features/news/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}
