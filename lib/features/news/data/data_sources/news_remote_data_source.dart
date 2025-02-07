import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:simple_news_app/core/errors/exceptions.dart';
import 'package:simple_news_app/core/utils/constants.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getArticles();
}

const kTopHeadlinesEndPoint = '/v2/top-headlines?';

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NewsRemoteDataSourceImpl(this._client);

  final Client _client;

  @override
  Future<List<ArticleModel>> getArticles() async {
    try {
      final url = '$kNewsBaseUrl$kTopHeadlinesEndPoint'
          'country=us&apiKey=$kNewsApiKey';
      final parseUri = Uri.parse(url);

      final response = await _client.get(parseUri);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] as String == 'error') {
        throw FetchArticlesException(
          message: data['message'] as String,
          statusCode: data['status'] as String,
        );
      }
      final articles = List<ArticleModel>.from(
        (data['articles'] as List).map(
          (article) => ArticleModel.fromMap(
            article as Map<String, dynamic>,
          ),
        ),
      );

      return articles;
    } on FetchArticlesException catch (e, s) {
      debugPrintStack(stackTrace: s);
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw FetchArticlesException(
        message: '$e',
        statusCode: '500',
      );
    }
  }
}
