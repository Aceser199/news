import 'package:flutter/material.dart';
import 'package:news/widgets/loading_container.dart';

import '../models/item_model.dart';

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.itemId,
    required this.itemMap,
    required this.depth,
  });
  final int itemId;
  final Map<int, Future<ItemModel?>> itemMap;
  final int depth;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        final item = snapshot.data!;
        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == '' ? const Text('Deleted') : Text(item.by!),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: depth * 16.0,
            ),
          ),
          const Divider(),
        ];

        children.add(buildText(item));
        children.addAll(item.kids.map((kidId) {
          return Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          );
        }).toList());

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    return Text(
      item.text
          .replaceAll('&#x27;', "'")
          .replaceAll('<p>', '\n\n')
          .replaceAll('</p>', '')
          .replaceAll(RegExp('\$quot;'), '"'),
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
      ),
    );
  }
}
