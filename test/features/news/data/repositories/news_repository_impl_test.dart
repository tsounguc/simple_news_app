import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/exceptions.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';
import 'package:simple_news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late NewsRemoteDataSource remoteDataSource;
  late NewsRepositoryImpl repositoryImpl;

  final testResponse = [const ArticleModel.empty()];

  setUp(() {
    remoteDataSource = MockNewsRemoteDataSource();
    repositoryImpl = NewsRepositoryImpl(remoteDataSource);
  });

  test(
    'given NewsRepositoryImpl '
    'when instantiated '
    'then instance should be a subclass of [NewsRepository]',
    () async {
      // Arrange
      // Act
      // Assert
      expect(repositoryImpl, isA<NewsRepository>());
    },
  );

  group(
    'getArticles - ',
    () {
      test(
        'given NewsRepositoryImpl '
        'when [NewsRemoteDatasource.getArticles] is called '
        'then return [List<Article>]',
        () async {
          // Arrange
          when(
            () => remoteDataSource.getArticles(),
          ).thenAnswer((_) async => testResponse);

          // Act
          final result = await repositoryImpl.getArticles();

          // Assert
          expect(
            result,
            Right<Failure, List<Article>>(testResponse),
          );
          verify(
            () => remoteDataSource.getArticles(),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
      test(
        'given NewsRepositoryImpl '
        'when [NewsRemoteDatasource.getArticles] call unsuccessful '
        'then return [FetchArticlesFailure]',
        () async {
          // Arrange
          const testException = FetchArticlesException(
            message: 'message',
            statusCode: '500',
          );
          when(
            () => remoteDataSource.getArticles(),
          ).thenThrow(testException);

          // Act
          final result = await repositoryImpl.getArticles();

          // Assert
          expect(
            result,
            Left<Failure, List<Article>>(
              FetchArticlesFailure.fromException(testException),
            ),
          );
          verify(
            () => remoteDataSource.getArticles(),
          ).called(1);
          verifyNoMoreInteractions(remoteDataSource);
        },
      );
    },
  );
}
