import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final String? content;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;

  const ArticleEntity({
    this.url,
    this.title,
    this.publishedAt,
    this.author,
    this.description,
    this.content,
    this.urlToImage,
  });

  @override
  List<Object?> get props => [
        author,
        title,
        description,
        content,
        url,
        urlToImage,
        publishedAt,
      ];
}
