import 'package:floor/floor.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';

@Entity(tableName: 'bookmarked_article', primaryKeys: ['title'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    String? url,
    String? title,
    String? author,
    String? content,
    String? urlToImage,
    String? description,
    String? publishedAt,
  }) : super(
          url: url,
          title: title,
          author: author,
          content: content,
          urlToImage: urlToImage,
          description: description,
          publishedAt: publishedAt,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        url: json['url'],
        title: json['title'],
        author: json['author'],
        content: json['content'],
        urlToImage: json['urlToImage'],
        description: json['description'],
        publishedAt: json['publishedAt'],
      );

  factory ArticleModel.fromEntity(ArticleEntity entity) => ArticleModel(
        url: entity.url,
        title: entity.title,
        author: entity.author,
        content: entity.content,
        urlToImage: entity.urlToImage,
        description: entity.description,
        publishedAt: entity.publishedAt,
      );
}
