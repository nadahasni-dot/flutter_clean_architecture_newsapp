import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    String? url,
    String? title,
    String? author,
    String? content,
    String? urlToImage,
    String? description,
    DateTime? publishedAt,
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
        publishedAt: json['publishedAt'] != null
            ? DateTime.parse(json['publishedAt'])
            : json['publishedAt'],
      );
}
