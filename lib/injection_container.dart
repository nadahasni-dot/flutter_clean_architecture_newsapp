// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/data_sources/remote/daily_news_api_service.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/repositories/article_repository_impl.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/usecases/get_daily_news_usecase.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<DailyNewsApiService>(DailyNewsApiService(sl()));
  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));
  sl.registerSingleton<GetDailyNewsUseCase>(GetDailyNewsUseCase(sl()));

  sl.registerFactory<RemoteArticleBloc>(() => RemoteArticleBloc(sl()));
}
