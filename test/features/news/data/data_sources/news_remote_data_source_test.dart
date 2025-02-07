import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/core/errors/exceptions.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements Client {}

void main() async {
  await dotenv.load();
  late Client client;
  late NewsRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = NewsRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  test(
    'given NewsRemoteDataSourceImpl '
    'when instantiated '
    'then instance should be a subclass of [NewsRemoteDataSource]',
    () {
      // Arrange
      // Act
      // Assert
      expect(remoteDataSource, isA<NewsRemoteDataSource>());
    },
  );

  group(
    'getArticles - ',
    () {
      final testJson = fixture('articles.json');
      test(
        'given NewsRemoteDataSourceImpl, '
        'when [NewsRemoteDataSourceImpl.getArticles] is called '
        'then return [List<ArticleModel>]',
        () async {
          // Arrange
          when(
            () => client.get(
              any(),
            ),
          ).thenAnswer(
            (_) async => Response(
              testJson,
              200,
              headers: {
                'content-type': 'application/json; charset=utf-8',
              },
            ),
          );

          // Act
          final result = await remoteDataSource.getArticles();

          // Assert
          expect(result, isA<List<ArticleModel>>());
          verify(() => client.get(any())).called(1);
          verifyNoMoreInteractions(client);
        },
      );

      test(
        'given NewsRemoteDataSourceImpl, '
        'when [NewsRemoteDataSourceImpl.getArticles] call unsuccessful '
        'and status is error '
        'then return [FetchArticlesException]',
        () async {
          // Arrange
          final testErrorResponse = fixture('error_response.json');
          when(
            () => client.get(
              any(),
            ),
          ).thenAnswer(
            (_) async => Response(
              testErrorResponse,
              200,
              headers: {
                'content-type': 'application/json; charset=utf-8',
              },
            ),
          );

          // Act
          final methodCall = remoteDataSource.getArticles;

          // Assert
          final message = (jsonDecode(
            testErrorResponse,
          ) as Map<String, dynamic>)['message'];

          final statusCode = (jsonDecode(
            testErrorResponse,
          ) as Map<String, dynamic>)['status'];

          expect(
            () async => methodCall(),
            throwsA(
              FetchArticlesException(
                message: message as String,
                statusCode: statusCode as String,
              ),
            ),
          );
          verify(() => client.get(any())).called(1);
          verifyNoMoreInteractions(client);
        },
      );
    },
  );
}
