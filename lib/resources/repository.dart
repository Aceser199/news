import 'dart:async';
import 'package:news/models/item_model.dart';
import 'package:news/resources/news_api_provider.dart';
import 'package:news/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[newsDbProvider];

  Future<List<dynamic>> fetchTopIds() async {
    return await sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;

    for (Source source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    if (item != null) {
      for (Cache cache in caches) {
        cache.addItem(item);
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
