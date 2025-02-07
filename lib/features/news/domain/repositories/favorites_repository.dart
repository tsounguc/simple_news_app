import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, void>> saveArticle(Article article);

  Future<Either<Failure, void>> removeArticle(Article article);

  Future<Either<Failure, bool>> isArticleFavorite(Article article);
}
