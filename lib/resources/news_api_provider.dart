import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:news/models/item_model.dart';

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<dynamic>> fetchTopIds() async {
    final response = await client.get(Uri.parse('$_root/topstories.json'));
    final ids = json.decode(response.body) as List<dynamic>;

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
