import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_news_app/features/news/domain/entity/article.dart';
import 'package:simple_news_app/features/news/presentation/news_cubit/news_cubit.dart';
import 'package:simple_news_app/features/news/presentation/views/article_detail_page.dart';
import 'package:simple_news_app/features/news/presentation/widgets/article_tile.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({super.key});

  @override
  State<NewsHomePage> createState() => _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage> {
  Timer? _autoRefreshTimer;

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().loadNewsArticles();
    _autoRefreshTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        context.read<NewsCubit>().loadNewsArticles();
      },
    );
  }

  @override
  void dispose() {
    _autoRefreshTimer?.cancel();
    super.dispose();
  } // Group the articles by source

  Map<String, List<Article>> _groupArticlesBySource(List<Article> articles) {
    final Map<String, List<Article>> groupedArticles = {};
    for (final article in articles) {
      final sourceName = article.source.name;
      if (groupedArticles.containsKey(sourceName)) {
        groupedArticles[sourceName]!.add(article);
      } else {
        groupedArticles[sourceName] = [article];
      }
    }
    return groupedArticles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is LoadingArticles) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ArticlesError) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(state.message),
              ),
            );
          }
          if (state is ArticlesLoaded) {
            final groupedArticles = _groupArticlesBySource(state.articles);

            return ListView(
                children: groupedArticles.entries.map((entry) {
              final sourceName = entry.key;
              final articlesForSource = entry.value;
              return ExpansionTile(
                title: Text(sourceName),
                children: articlesForSource.map((article) {
                  return ArticleTile(
                    article: article,
                    onFavoriteToggle: () {
                      context.read<NewsCubit>().toggleFavoriteStatus(article);
                    },
                  );
                }).toList(),
              );
            }).toList());
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
