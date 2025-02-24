import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
    required this.source,
  });

  Article.empty()
      : this(
          author: '',
          title: '',
          description: '',
          url: '',
          imageUrl: '',
          publishedAt: '',
          content: '',
          source: const NewsSource.empty(),
        );

  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String content;
  final NewsSource source;

  @override
  List<Object?> get props => [
        author,
        title,
        description,
        url,
        imageUrl,
        publishedAt,
        content,
        source,
      ];
}

class NewsSource extends Equatable {
  const NewsSource({
    required this.id,
    required this.name,
  });

  const NewsSource.empty()
      : this(
          id: '',
          name: '',
        );

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
