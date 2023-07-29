import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/bookmark/news_bookmark_page.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/daily_news/daily_news_page.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/detail/news_detail_page.dart';
import 'package:go_router/go_router.dart';

final appRoute = GoRouter(
  routes: [
    GoRoute(
      path: DailyNewsPage.routeName,
      name: DailyNewsPage.routeName,
      builder: (context, state) => const DailyNewsPage(),
    ),
    GoRoute(
      path: NewsBookmarkPage.routeName,
      name: NewsBookmarkPage.routeName,
      builder: (context, state) => const NewsBookmarkPage(),
    ),
    GoRoute(
      path: NewsDetailPage.routeName,
      name: NewsDetailPage.routeName,
      builder: (context, state) {
        final article = state.extra as ArticleEntity;

        return NewsDetailPage(article: article);
      },
    ),
  ],
);
