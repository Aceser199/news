import 'package:flutter/material.dart';
import 'package:news/blocs/comments_provider.dart';
import 'package:news/widgets/loading_container.dart';

import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetails extends StatelessWidget {
  static const routeName = '/news-details';

  const NewsDetails({super.key, required this.itemId});
  final int itemId;

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Details #$itemId'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingContainer();
        }

        final itemFuture = snapshot.data![itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const LoadingContainer();
            }

            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel itemModel, Map<int, Future<ItemModel?>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(itemModel));

    final commentsList = itemModel.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 1,
      );
    }).toList();

    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel itemModel) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10.0),
      child: Text(
        itemModel.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
