import 'package:simple_news_app/core/use_case.dart';
import 'package:simple_news_app/core/utils/typedefs.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/favorites_repository.dart';

class SaveArticle extends UseCaseWithParams<void, Article> {
  SaveArticle(this._repository);

  final FavoritesRepository _repository;

  @override
  ResultVoid call(Article params) => _repository.saveArticle(params);
}
