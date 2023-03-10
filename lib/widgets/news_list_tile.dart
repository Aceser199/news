import 'package:flutter/material.dart';
import 'package:news/models/item_model.dart';
import 'package:news/blocs/stories_provider.dart';
import 'package:news/widgets/loading_container.dart';

class NewsListTile extends StatelessWidget {
  const NewsListTile({super.key, required this.itemId});
  final int itemId;

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const LoadingContainer();
            }

            return buildTile(itemSnapshot.data!);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} votes'),
          trailing: Column(
            children: <Widget>[
              const Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        const Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
