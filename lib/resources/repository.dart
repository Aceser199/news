import 'dart:async';
import 'package:news/models/item_model.dart';
import 'package:news/resources/news_api_provider.dart';
import 'package:news/resources/news_db_provider.dart';

class Repository {
  NewsDbProvider dbProvider = NewsDbProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<dynamic>> fetchTopIds() async {
    return await apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);
    return item;
  }
}
