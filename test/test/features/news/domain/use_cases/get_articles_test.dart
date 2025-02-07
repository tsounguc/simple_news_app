import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

import 'news_repository.mock.dart';

void main() {
  late NewsRepository repository;
  late GetArticles useCase;
  setUp(() {
    repository = MockNewsRepository();
    useCase = GetArticles();
  });

  final testResponse = [Article.empty()];
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
      verify(() => repository.getArticles());
      verifyNoMoreInteractions(repository);
    },
  );
}
