import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_local_data_source.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_remote_data_source.dart';
import 'package:simple_news_app/features/news/data/repositories/favorites_repository_impl.dart';
import 'package:simple_news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';
import 'package:simple_news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:simple_news_app/features/news/domain/use_cases/is_article_favorite.dart';
import 'package:simple_news_app/features/news/domain/use_cases/remove_article.dart';
import 'package:simple_news_app/features/news/domain/use_cases/save_article.dart';
import 'package:simple_news_app/features/news/presentation/news_cubit/news_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initNews();
}

Future<void> _initNews() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => NewsCubit(
        getArticles: serviceLocator(),
        saveArticle: serviceLocator(),
        removeArticle: serviceLocator(),
        isArticleFavorite: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(
      () => GetArticles(serviceLocator()),
    )
    ..registerLazySingleton(
      () => SaveArticle(serviceLocator()),
    )
    ..registerLazySingleton(
      () => RemoveArticle(serviceLocator()),
    )
    ..registerLazySingleton(
      () => IsArticleFavorite(serviceLocator()),
    )
    // Repositories
    ..registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(serviceLocator()),
    )
    // Data Sources
    ..registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(serviceLocator()),
    )
    // External dependencies
    ..registerLazySingleton(DatabaseHelper.new)
    ..registerLazySingleton(Client.new);
}
