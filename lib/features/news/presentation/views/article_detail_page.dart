import 'package:flutter/material.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    required this.article,
    super.key,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Column(
        children: [
          Text(article.content),
        ],
      ),
    );
  }
}
