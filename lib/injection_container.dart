// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/data_sources/remote/daily_news_api_service.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/repositories/article_repository_impl.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_bookmarked_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_daily_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/remove_article_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // DB SERVICE
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // DIO SERVICE
  sl.registerSingleton<Dio>(Dio());

  // NEWS SERVICE
  sl.registerSingleton<DailyNewsApiService>(DailyNewsApiService(sl<Dio>()));
  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(sl<DailyNewsApiService>(), sl<AppDatabase>()));

  // USE CASES
  sl.registerSingleton<GetDailyNewsUseCase>(
      GetDailyNewsUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<GetBookmarkedNewsUseCase>(
      GetBookmarkedNewsUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<SaveArticleUseCase>(
      SaveArticleUseCase(sl<ArticleRepository>()));
  sl.registerSingleton<RemoveArticleUseCase>(
      RemoveArticleUseCase(sl<ArticleRepository>()));
}
