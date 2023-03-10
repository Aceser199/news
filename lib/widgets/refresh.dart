import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  const Refresh({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        var _ = bloc.fetchTopIds();
      },
    );
  }
}
