import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/core/use_case.dart';
import 'package:simple_news_app/core/utils/typedefs.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

class GetArticles extends UseCase<List<Article>> {
  GetArticles(this._repository);

  final NewsRepository _repository;

  @override
  ResultFuture<List<Article>> call() => _repository.getArticles();
}
