import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/widgets/article_card.dart';

class NewsBookmarkPage extends StatefulWidget {
  static const routeName = '/news-bookmark';

  const NewsBookmarkPage({super.key});

  @override
  State<NewsBookmarkPage> createState() => _NewsBookmarkPageState();
}

class _NewsBookmarkPageState extends State<NewsBookmarkPage> {
  Future<void> _onRefresh(BuildContext context) async {
    context.read<LocalArticleBloc>().add(const GetSavedArticles());
  }

  @override
  void initState() {
    super.initState();
    _onRefresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _onRefresh(context);
        },
        child: BlocBuilder<LocalArticleBloc, LocalArticleState>(
          builder: (context, state) {
            if (state is LocalArticleInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LocalArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.articles?.isEmpty == true) {
              return const Center(
                child: Text('No Saved News'),
              );
            }

            return ListView.separated(
              itemCount: state.articles!.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) {
                ArticleEntity article = state.articles![index];

                return ArticleCard(
                  article: article,
                  isBookmarked: true,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
            );
          },
        ),
      ),
    );
  }
}
