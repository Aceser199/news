import 'dart:async';
import 'package:news/models/item_model.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  // Streams
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sinks
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  _commentsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        cache[id]!.then((comment) =>
            comment?.kids.forEach((kidId) => fetchItemWithComments(kidId)));
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  Future<List<int>> getComments(int itemId) async {
    await Future.delayed(const Duration(seconds: 2));
    return [itemId + 1, itemId + 2, itemId + 3, itemId + 4];
  }
}
