import 'package:equatable/equatable.dart';

class FetchArticlesException extends Equatable implements Exception {
  const FetchArticlesException({
    required this.message,
    required this.statusCode,
  });
  final String message;
  final String statusCode;
  @override
  List<Object?> get props => [message, statusCode];
}

class FavoritesException extends Equatable implements Exception {
  const FavoritesException({
    required this.message,
    required this.statusCode,
  });
  final String message;
  final String statusCode;
  @override
  List<Object?> get props => [message, statusCode];
}
