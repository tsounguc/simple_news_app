import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';

abstract class NewsRepository {
  const NewsRepository();
  Future<Either<Failure, List<Article>>> getArticles();
}
