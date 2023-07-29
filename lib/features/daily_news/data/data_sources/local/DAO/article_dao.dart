import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/data/models/article_model.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM bookmarked_article')
  Future<List<ArticleModel>> getArticles();
}
