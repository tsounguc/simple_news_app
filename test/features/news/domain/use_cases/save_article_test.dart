import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';
import 'package:simple_news_app/features/news/domain/use_cases/save_article.dart';

import 'favorites_repository.mock.dart';

void main() {
  late FavoritesRepository repository;
  late SaveArticle useCase;

  final testArticle = Article.empty();
  final testFailure = DatabaseFailure(
    message: 'message',
    statusCode: 'statusCode',
  );
  setUp(() {
    repository = MockFavoritesRepository();
    useCase = SaveArticle(repository);
    registerFallbackValue(testArticle);
  });

  test(
    'given SaveArticle use case '
    'when instantiated '
    'then call [NewsRepository.saveArticle] '
    'and return [void]',
    () async {
      // Arrange
      when(() => repository.saveArticle(any())).thenAnswer(
        (_) async => const Right(null),
      );

      // Act
      final result = await useCase(testArticle);

      // Assert
      expect(
        result,
        equals(const Right<Failure, void>(null)),
      );
      verify(() => repository.saveArticle(testArticle)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'given SaveArticle use case '
    'when instantiated '
    'then [NewsRepository.saveArticle] is unsuccessful '
    'return [DatabaseFailure ]',
    () async {
      // Arrange
      when(() => repository.saveArticle(any())).thenAnswer(
        (_) async => Left(testFailure),
      );

      // Act
      final result = await useCase(testArticle);

      // Assert
      expect(
        result,
        equals(Left<Failure, void>(testFailure)),
      );
      verify(() => repository.saveArticle(testArticle)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
