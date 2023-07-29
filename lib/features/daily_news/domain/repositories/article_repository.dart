import 'package:flutter_clean_architecture_newsapp/core/resources/data_state.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getDailyNews();

  Future<List<ArticleEntity>> getBookmarkedNews();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article);
}
