import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';
import 'package:simple_news_app/features/news/domain/use_cases/get_articles.dart';

import 'news_repository.mock.dart';

void main() {
  late NewsRepository repository;
  late GetArticles useCase;

  final testResponse = [Article.empty()];
  final testFailure = FetchArticlesFailure(
    message: 'message',
    statusCode: '400',
  );

  setUp(() {
    repository = MockNewsRepository();
    useCase = GetArticles(repository);
  });

  test(
    'given GetArticles use case '
    'when instantiated '
    'then call [NewsRepository.getArticles] '
    'and return [List<Article>]',
    () async {
      // Arrange
      when(() => repository.getArticles()).thenAnswer(
        (_) async => Right(testResponse),
      );

      // Act
      final result = await useCase();

      // Assert
      expect(
        result,
        equals(Right<Failure, List<Article>>(testResponse)),
      );
      verify(() => repository.getArticles()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given GetArticles use case '
    'when instantiated '
    'then [NewsRepository.getArticles] is unsuccessful '
    'return [FetchArticlesFailure]',
    () async {
      // Arrange
      when(() => repository.getArticles()).thenAnswer(
        (_) async => Left(testFailure),
      );

      // Act
      final result = await useCase();

      // Assert
      expect(
        result,
        equals(Left<Failure, List<Article>>(testFailure)),
      );
      verify(() => repository.getArticles()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
