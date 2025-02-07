import 'package:simple_news_app/core/use_case.dart';
import 'package:simple_news_app/core/utils/typedefs.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';

class IsArticleFavorite extends UseCaseWithParams<bool, Article> {
  IsArticleFavorite(this.repository);

  final FavoritesRepository repository;

  @override
  ResultFuture<bool> call(Article params) => repository.isArticleFavorite(params);
}
