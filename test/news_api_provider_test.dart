import 'package:flutter_test/flutter_test.dart';
import 'package:news/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
// import 'package:test/test.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // Setup of test case
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      List<int> ids = [1, 2, 3, 4];
      return Response(json.encode(ids), 200);
    });

    // expectation
    final ids = await newsApi.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      final jsonMap = {'id': 123};
      return Response(jsonEncode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(999);

    expect(item.id, 123);
  });
}
