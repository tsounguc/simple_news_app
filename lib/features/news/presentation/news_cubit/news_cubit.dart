import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:simple_news_app/features/news/domain/use_cases/is_article_favorite.dart';
import 'package:simple_news_app/features/news/domain/use_cases/remove_article.dart';
import 'package:simple_news_app/features/news/domain/use_cases/save_article.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({
    required GetArticles getArticles,
    required SaveArticle saveArticle,
    required RemoveArticle removeArticle,
    required IsArticleFavorite isArticleFavorite,
  })  : _getArticles = getArticles,
        _saveArticle = saveArticle,
        _removeArticle = removeArticle,
        _isArticleFavorite = isArticleFavorite,
        super(const NewsInitial());
  final GetArticles _getArticles;
  final SaveArticle _saveArticle;
  final RemoveArticle _removeArticle;
  final IsArticleFavorite _isArticleFavorite;

  Future<void> loadNewsArticles() async {
    emit(const LoadingArticles());
    final result = await _getArticles();

    result.fold(
      (failure) => emit(
        ArticlesError(message: failure.message),
      ),
      (articles) => emit(
        ArticlesLoaded(articles: articles),
      ),
    );
  }

  Future<void> toggleFavoriteStatus(Article article) async {
    final favoriteResult = await _isArticleFavorite(article);
    await favoriteResult.fold(
      (failure) {
        emit(ArticlesError(message: failure.message));
      },
      (isFavorite) async {
        if (isFavorite) {
          // Remove article from favorites.
          final removeResult = await _removeArticle(article);
          removeResult.fold(
            (failure) => emit(ArticlesError(message: failure.message)),
            (_) {
              // Optionally, update state to reflect the change.
              // You might also refresh the articles or favorites list.
            },
          );
        } else {
          // Save article to favorites.
          final saveResult = await _saveArticle(article);
          saveResult.fold(
            (failure) => emit(ArticlesError(message: failure.message)),
            (_) {
              // Optionally, update state to reflect the change.
            },
          );
        }
      },
    );
  }
}
