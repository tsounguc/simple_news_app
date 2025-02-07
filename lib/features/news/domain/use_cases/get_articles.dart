import 'package:dartz/dartz.dart';
import 'package:simple_news_app/core/errors/failures.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/domain/repositories/news_repository.dart';

class GetArticles {
  GetArticles(this._repository);

  final NewsRepository _repository;

  Future<Either<Failure, List<Article>>> call()  => _repository.getArticles();
}
