import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late String testJson;
  late Map<String, dynamic> testMap;
  late ArticleModel testModel;

  setUpAll(() {
    testJson = fixture('article.json');
    testMap = jsonDecode(testJson) as Map<String, dynamic>;
    testModel = ArticleModel.fromMap(testJson);
  });

  test(
    'given [ArticleModel], '
    'when instantiated '
    'then instance should be a subclass of [Article]',
    () {
      // Arrange
      // Act
      // Assert
      expect(testModel, isA<Article>());
    },
  );

  group('fromMap - ', () {
    test(
      'given [ArticleModel] '
      'when fromMap is called '
      'then return [ArticleModel] with correct data ',
      () {
        // Arrange
        // Act
        final result = ArticleModel.fromMap(testMap);

        // Assert
        expect(result, isA<ArticleModel>());
        expect(result, equals(testModel));
      },
    );
  });
}
