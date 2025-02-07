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

  const ArticleModel.empty()
      : this(
          author: '_empty.author',
          title: '_empty.title',
          description: '_empty.description',
          url: '_empty.url',
          imageUrl: '_empty.imageUrl',
          publishedAt: '_empty.publishedAt',
          content: '_empty.content',
          source: const NewsSourceModel.empty(),
        );

  ArticleModel.fromMap(Map<String, dynamic> map)
      : this(
          author: map['author'] as String? ?? '',
          title: map['title'] as String? ?? '',
          description: map['description'] as String? ?? '',
          url: map['url'] as String? ?? '',
          imageUrl: map['urlToImage'] as String? ?? '',
          publishedAt: map['publishedAt'] as String? ?? '',
          content: map['content'] as String? ?? '',
          source: map['source'] != null
              ? NewsSourceModel.fromMap(map['source'] as Map<String, dynamic>)
              : const NewsSourceModel.empty(),
        );

  Map<String, dynamic> toMap() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': imageUrl,
        'publishedAt': publishedAt,
        'content': content,
        'source': (source as NewsSourceModel).toMap()
      };
}

class NewsSourceModel extends NewsSource {
  const NewsSourceModel({
    required super.id,
    required super.name,
  });
  const NewsSourceModel.empty()
      : this(
          id: '_empty.id',
          name: '_empty.name',
        );

  NewsSourceModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] as String? ?? '',
          name: map['name'] as String? ?? '',
        );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}
