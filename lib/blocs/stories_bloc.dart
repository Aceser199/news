import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:news/resources/repository.dart';
import 'package:news/models/item_model.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;

  void fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
