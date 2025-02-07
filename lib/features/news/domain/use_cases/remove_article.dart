import 'package:simple_news_app/core/use_case.dart';
import 'package:simple_news_app/core/utils/typedefs.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';

class RemoveArticle extends UseCaseWithParams<void, Article> {
  RemoveArticle(this.repository);

  final FavoritesRepository repository;

  @override
  ResultFuture<void> call(Article params) => repository.removeArticle(params);
}
