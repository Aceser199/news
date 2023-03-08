import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:news/models/item_model.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json' as Uri);
    final ids = json.decode(response.body);

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json' as Uri);
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
