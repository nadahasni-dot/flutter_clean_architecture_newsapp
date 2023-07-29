import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/daily_news_page.dart';
import 'package:go_router/go_router.dart';

final appRoute = GoRouter(
  routes: [
    GoRoute(
      path: DailyNewsPage.routeName,
      name: DailyNewsPage.routeName,
      builder: (context, state) => const DailyNewsPage(),
    )
  ],
);
