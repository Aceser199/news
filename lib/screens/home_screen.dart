import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';
import 'package:news/widgets/news_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: StoriesProvider(child: const NewsList()),
    );
  }
}
