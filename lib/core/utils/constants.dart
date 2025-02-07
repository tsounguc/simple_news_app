import 'package:flutter_dotenv/flutter_dotenv.dart';

const kNewsBaseUrl = 'https://newsapi.org';
final kNewsApiKey = dotenv.env['NEWS_API_KEY'];
