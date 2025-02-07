import 'package:simple_news_app/features/news/domain/entity/article.dart';

class ArticleModel extends Article {
  const ArticleModel({
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.imageUrl,
    required super.publishedAt,
    required super.content,
    required super.source,
  });

  ArticleModel.empty()
      : this(
          author: '_empty.author',
          title: '_empty.title',
          description: '_empty.description',
          url: '_empty.url',
          imageUrl: '_empty.imageUrl',
          publishedAt: DateTime.now(),
          content: '_empty.content',
          source: const SourceModel.empty(),
        );
}

class SourceModel extends Source {
  const SourceModel({
    required super.id,
    required super.name,
  });
  const SourceModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
        );
}
