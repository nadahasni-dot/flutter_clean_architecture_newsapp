import 'package:flutter/material.dart';

class NewsBookmarkPage extends StatelessWidget {
  static const routeName = '/news-bookmark';

  const NewsBookmarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
      ),
    );
  }
}
