import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_newsapp/configs/routes/route.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_bookmarked_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_daily_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/remove_article_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/injection_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load environment variables
  await dotenv.load(fileName: ".env");

  // load all dependencies using service locator
  await initializeDependencies();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
          create: (context) => RemoteArticleBloc(sl<GetDailyNewsUseCase>())
            ..add(const GetArticles()),
        ),
        BlocProvider<LocalArticleBloc>(
          create: (context) => LocalArticleBloc(
            sl<GetBookmarkedNewsUseCase>(),
            sl<RemoveArticleUseCase>(),
            sl<SaveArticleUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'NEWS APP',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRoute,
      ),
    );
  }
}
