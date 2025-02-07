import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}

void main() {
  late NewsRemoteDataSource remoteDataSource;
  late NewsRepositoryImpl repositoryImpl;

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
}
