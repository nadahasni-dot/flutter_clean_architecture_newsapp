import 'dart:io';
import 'dart:developer';

import 'package:flutter_clean_architecture_newsapp/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/data_sources/remote/daily_news_api_service.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/models/article_model.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final DailyNewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getDailyNews() async {
    final apiKey = dotenv.get('NEWS_API_KEY');

    try {
      final httpResponse = await _newsApiService.getDailyNews(
        apiKey: apiKey,
        country: 'us',
        sortBy: 'popularity',
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      return DataFailed(DioException(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
      ));
    } on DioException catch (e) {
      log(e.toString());
      return DataFailed(e);
    }
  }
}
