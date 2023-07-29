part of 'local_article_bloc.dart';

abstract class LocalArticleState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticleState({this.articles});

  @override
  List<Object?> get props => [articles];
}

class LocalArticleInitial extends LocalArticleState {
  const LocalArticleInitial();
}

class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles)
      : super(articles: articles);
}
