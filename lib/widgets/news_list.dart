import 'package:flutter/material.dart';
import 'package:news/blocs/stories_provider.dart';
import 'package:path/path.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    // TODO: implement build
    bloc.fetchTopIds();
    return buildList(bloc);
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, int index) {
            return Text(snapshot.data![index].toString());
          },
        );
      },
    );
  }
}
