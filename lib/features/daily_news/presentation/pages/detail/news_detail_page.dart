import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_newsapp/core/constants/constants.dart';
import 'package:flutter_clean_architecture_newsapp/core/util/date_format.dart';
import 'package:flutter_clean_architecture_newsapp/features/daily_news/domain/entities/article_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  static const routeName = '/news-detail';

  final ArticleEntity article;

  const NewsDetailPage({
    super.key,
    required this.article,
  });

  void _openArticle() {
    if (article.url == null) return;

    try {
      final uri = Uri.parse(article.url!);

      launchUrl(
        uri,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? '-'),
      ),
      body: ListView(
        children: [
          Hero(
            tag: article.urlToImage ?? '-',
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? noImage,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  article.publishedAt != null
                      ? dateFormat.format(DateTime.parse(article.publishedAt!))
                      : '-',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  article.title ?? '-',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Text(
                  article.description ?? '-',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.content ?? '-',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _openArticle,
                  child: const Text('View Full Text'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
