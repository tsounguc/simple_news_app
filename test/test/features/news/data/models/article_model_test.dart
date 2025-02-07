import 'package:flutter_test/flutter_test.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late String testJson;
  late Map<String, dynamic> testMap;
  late ArticleModel testModel;

  setUpAll(() {
    testJson = fixture('article.json');
    testModel = ArticleModel.empty();
    testMap = testModel.toMap();
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
}
