import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  static const routeName = '/comments';

  const NewsDetails({super.key, required this.itemId});
  final int itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top News'),
      ),
      body: const Text('Comments'),
    );
  }
}
