import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/bookmark/news_bookmark_page.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/widgets/article_card.dart';
import 'package:go_router/go_router.dart';

class DailyNewsPage extends StatefulWidget {
  static const routeName = '/';

  const DailyNewsPage({super.key});

  @override
  State<DailyNewsPage> createState() => _DailyNewsPageState();
}

class _DailyNewsPageState extends State<DailyNewsPage> {
  Future<void> _onRefresh(BuildContext context) async {
    context.read<RemoteArticleBloc>().add(const GetArticles());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Daily News'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(NewsBookmarkPage.routeName),
            icon: const Icon(Icons.bookmark),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _onRefresh(context);
        },
        child: BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
          builder: (context, state) {
            if (state is RemoteArticleInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RemoteArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is RemoteArticleError) {
              return Center(
                  child: IconButton(
                onPressed: () => _onRefresh(context),
                icon: const Icon(Icons.refresh),
              ));
            }

            return ListView.separated(
              itemCount: state.articles!.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                ArticleEntity article = state.articles![index];

                return ArticleCard(article: article);
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            );
          },
        ),
      ),
    );
  }
}
