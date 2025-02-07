import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/use_cases/get_articles.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({required GetArticles getArticles})
      : _getArticles = getArticles,
        super(const NewsInitial());
  final GetArticles _getArticles;

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
}
