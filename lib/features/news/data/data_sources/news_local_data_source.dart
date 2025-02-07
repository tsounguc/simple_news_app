import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:simple_news_app/features/news/data/models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<void> saveArticle(Article article);

  Future<void> removeArticle(Article article);

  Future<List<ArticleModel>> getSavedArticles();

  Future<bool> isArticleSaved(Article article);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  NewsLocalDataSourceImpl(this.dbHelper);

  final DatabaseHelper dbHelper;

  @override
  Future<void> saveArticle(Article article) async {
    await dbHelper.insertFavorite(article as ArticleModel);
  }

  @override
  Future<void> removeArticle(Article article) async {
    await dbHelper.removeFavorite(article.url);
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return dbHelper.getFavorites();
  }

  @override
  Future<bool> isArticleSaved(Article article) async {
    return dbHelper.isFavorite(article.url);
  }
}

class DatabaseHelper {
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  // Singleton instance.
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'news_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        imageUrl TEXT,
        publishedAt TEXT,
        content TEXT,
        sourceId TEXT,
        sourceName TEXT
      )
    ''');
  }

  Future<int> insertFavorite(ArticleModel article) async {
    final db = await database;
    return db.insert('favorites', {
      'author': article.author,
      'title': article.title,
      'description': article.description,
      'url': article.url,
      'imageUrl': article.imageUrl,
      'publishedAt': article.publishedAt,
      'content': article.content,
      'sourceId': article.source.id,
      'sourceName': article.source.name,
    });
  }

  Future<List<ArticleModel>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return ArticleModel(
        author: maps[i]['author'] as String,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String,
        url: maps[i]['url'] as String,
        imageUrl: maps[i]['imageUrl'] as String,
        publishedAt: maps[i]['publishedAt'] as String,
        content: maps[i]['content'] as String,
        source: NewsSourceModel(
          id: maps[i]['sourceId'] as String,
          name: maps[i]['sourceName'] as String,
        ),
      );
    });
  }

  Future<int> removeFavorite(String url) async {
    final db = await database;
    return db.delete('favorites', where: 'url = ?', whereArgs: [url]);
  }

  Future<bool> isFavorite(String url) async {
    final db = await database;
    final result = await db.query('favorites', where: 'url = ?', whereArgs: [url]);
    return result.isNotEmpty;
  }
}
