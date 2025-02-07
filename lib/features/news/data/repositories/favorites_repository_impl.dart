import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_local_data_source.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this.localDataSource);
  final NewsLocalDataSource localDataSource;

  @override
  Future<Either<Failure, void>> saveArticle(Article article) async {
    try {
      // We assume article is an ArticleModel or can be converted appropriately.
      await localDataSource.saveArticle(article as ArticleModel);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, void>> removeArticle(Article article) async {
    try {
      await localDataSource.removeArticle(article);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getFavoriteArticles() async {
    try {
      final favorites = await localDataSource.getSavedArticles();
      return Right(favorites);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, bool>> isArticleFavorite(Article article) async {
    try {
      final isFavorite = await localDataSource.isArticleSaved(article);
      return Right(isFavorite);
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString(), statusCode: 400));
    }
  }
}
