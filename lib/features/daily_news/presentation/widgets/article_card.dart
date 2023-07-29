import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_newsapp/core/util/date_format.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;

  const ArticleCard({super.key, required this.article});

  void _saveArticle() {
    log('Saving...');
  }

  void _openArticle() {
    if (article.url == null) return;

    try {
      Uri uri = Uri.parse(article.url!);

      launchUrl(uri);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openArticle,
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
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ??
                        'https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: _saveArticle,
                      icon: const Icon(Icons.bookmark_border),
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
                        ? dateFormat.format(article.publishedAt!)
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
