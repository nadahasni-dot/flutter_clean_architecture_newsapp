part of 'remote_article_bloc.dart';

abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}
