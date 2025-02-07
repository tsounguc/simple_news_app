import 'package:simple_news_app/core/utils/typedefs.dart';

abstract class UseCase<T> {
  const UseCase();

  ResultFuture<T> call();
}

abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  ResultFuture<T> call(Params params);
}

abstract class StreamUseCaseWithParams<T, Params> {
  const StreamUseCaseWithParams();
  ResultStream<T> call(Params params);
}
