part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();
}

final class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}
