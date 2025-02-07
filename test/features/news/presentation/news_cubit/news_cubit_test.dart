import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:simple_news_app/features/news/presentation/news_cubit/news_cubit.dart';

class MockGetArticles extends Mock implements GetArticles {}

void main() {
  late GetArticles getArticles;
  late NewsCubit cubit;

  setUp(() {
    getArticles = MockGetArticles();
    cubit = NewsCubit(getArticles: getArticles);
  });

  tearDown(() => cubit.close());

  test(
    'given NewsCubit '
    'when cubit is instantiated '
    'then initial state should [NewsInitial]',
    () async {
      // Arrange
      // Act
      // Assert
      expect(cubit.state, const NewsInitial());
    },
  );

  group('loadNewsArticles - ', () {
    final articles = [Article.empty()];
    final testFailure = FetchArticlesFailure(
      message: 'message',
      statusCode: '500',
    );
    blocTest<NewsCubit, NewsState>(
      'given NewsCubit '
      'when [NewsCubit.loadNewsArticles] call completed successfully '
      'then emit [LoadingArticles, ArticlesLoaded]',
      build: () {
        when(() => getArticles()).thenAnswer(
          (_) async => Right(articles),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadNewsArticles(),
      expect: () => [
        const LoadingArticles(),
        ArticlesLoaded(articles: articles),
      ],
      verify: (cubit) {
        verify(() => getArticles()).called(1);
        verifyNoMoreInteractions(getArticles);
      },
    );

    blocTest<NewsCubit, NewsState>(
      'given NewsCubit '
      'when [NewsCubit.loadNewsArticles] call unsuccessfully '
      'then emit [LoadingArticles, ArticlesError]',
      build: () {
        when(() => getArticles()).thenAnswer(
          (_) async => Left(testFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.loadNewsArticles(),
      expect: () => [
        const LoadingArticles(),
        ArticlesError(message: testFailure.message),
      ],
      verify: (cubit) {
        verify(() => getArticles()).called(1);
        verifyNoMoreInteractions(getArticles);
      },
    );
  });
}
