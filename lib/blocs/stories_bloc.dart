import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:news/resources/repository.dart';
import 'package:news/models/item_model.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
  final _itemsFetcher = PublishSubject<int>();

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;
  // THIS IS BAD!!! DON'T DO THIS!!! - BELOW
  // Stream<Map<int, Future<ItemModel?>>> get items =>
  //     _items.stream.transform(_itemsTransformer());
  // ^ THIS IS BAD DON'T DO THIS - ABOVE

  // Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  Future<void> clearCache() async {
    return await _repository.clearCache();
  }

  // Only because the API is sending one by one
  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel?>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
