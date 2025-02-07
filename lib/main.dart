import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_news_app/core/services/service_locator.dart';
import 'package:simple_news_app/features/news/presentation/news_cubit/news_cubit.dart';
import 'package:simple_news_app/features/news/presentation/views/news_home_page.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
  await setUpServices();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<NewsCubit>(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NewsHomePage(),
      ),
    );
  }
}
