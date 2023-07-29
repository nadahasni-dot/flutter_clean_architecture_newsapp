import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/core/constants/constants.dart';
import 'package:flutter_clean_architecture_newsapp/core/util/date_format.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/presentation/pages/detail/news_detail_page.dart';
import 'package:go_router/go_router.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;
  final bool isBookmarked;

  const ArticleCard(
      {super.key, required this.article, this.isBookmarked = false});

  void _saveArticle(BuildContext context) {
    context.read<LocalArticleBloc>().add(SaveArticle(article));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Article Saved'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _removeArticle(BuildContext context) {
    context.read<LocalArticleBloc>().add(RemoveArticle(article));

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Removed From Bookmark'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  void _openArticle(BuildContext context) =>
      context.pushNamed(NewsDetailPage.routeName, extra: article);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openArticle(context),
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Hero(
                    tag: article.urlToImage ?? '-',
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage ?? noImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        if (isBookmarked) {
                          _removeArticle(context);
                          return;
                        }

                        _saveArticle(context);
                      },
                      icon: isBookmarked
                          ? const Icon(Icons.bookmark_remove)
                          : const Icon(Icons.bookmark_add),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    article.publishedAt != null
                        ? dateFormat
                            .format(DateTime.parse(article.publishedAt!))
                        : '-',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    article.title ?? '-',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? '-',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
