part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {
  const NewsInitial();
}

final class LoadingArticles extends NewsState {
  const LoadingArticles();
}

final class ArticlesLoaded extends NewsState {
  const ArticlesLoaded({required this.articles});

  final List<Article> articles;

  @override
  List<Object> get props => [articles];
}

class ArticlesError extends NewsState {
  const ArticlesError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
