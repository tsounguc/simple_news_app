import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/exceptions.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  const NewsRepositoryImpl(this._remoteDataSource);

  final NewsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Article>>> getArticles() async {
    try {
      final result = await _remoteDataSource.getArticles();
      return Right(result);
    } on FetchArticlesException catch (e) {
      return Left(FetchArticlesFailure.fromException(e));
    }
  }
}
