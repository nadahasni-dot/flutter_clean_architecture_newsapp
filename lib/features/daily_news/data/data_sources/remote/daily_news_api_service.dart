import 'package:flutter_clean_architecture_newsapp/core/constants/constants.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/models/article_model.dart';
import 'package:retrofit/retrofit.dart';
// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

part 'daily_news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseUrl)
abstract class DailyNewsApiService {
  factory DailyNewsApiService(Dio dio) = _DailyNewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getDailyNews({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('sortBy') String? sortBy,
  });
}
