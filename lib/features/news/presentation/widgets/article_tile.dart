import 'package:flutter/material.dart';
import 'package:simple_news_app/features/news/data/data_sources/news_local_data_source.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/presentation/views/article_detail_page.dart';

class ArticleTile extends StatefulWidget {
  const ArticleTile({
    required this.article,
    required this.onFavoriteToggle,
    super.key,
  });
  final Article article;
  final VoidCallback onFavoriteToggle;

  @override
  State<ArticleTile> createState() => _ArticleTileState();
}

class _ArticleTileState extends State<ArticleTile> {
  bool isFavorite = false;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final fav = await _dbHelper.isFavorite(widget.article.url);
    setState(() {
      isFavorite = fav;
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await _dbHelper.removeFavorite(widget.article.url);
    } else {
      await _dbHelper.insertFavorite(widget.article as ArticleModel);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavoriteToggle.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.article.title),
        subtitle: Text(
          widget.article.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: _toggleFavorite,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<ArticleDetailPage>(
              builder: (context) => ArticleDetailPage(article: widget.article),
            ),
          );
        },
      ),
    );
  }
}
