import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
//  test('FetchTopIds return a list of ids', () {
//    final sum = 1+3;
//    expect(sum, 4);
//  });

  test('FetchTopIds return a list of ids', () async {
    final newsApi = NewsApiProvider();
    var dataSet = [1,2,3,4];
    newsApi.client = MockClient((request) async {
      return Response(json.encode(dataSet), 200);
    });

    final ids = await newsApi.fetchTopIds();

    expect(ids, dataSet);
  });

  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    var jsonMap = {"id": 123};
    newsApi.client = MockClient((request) async {
      return Response(json.encode(jsonMap), 200);
    });

    final item = await newsApi.fetchItem(123);

    expect(item.id, 123);

  });


}
