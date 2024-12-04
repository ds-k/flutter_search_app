import 'dart:convert';
import 'package:flutter_search_app/data/model/location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String jsonString = """
{
      "title": "별내행정복지센터",
      "link": "",
      "category": "공공,사회기관>행정복지센터",
      "description": "",
      "telephone": "",
      "address": "경기도 남양주시 별내동 1028",
      "roadAddress": "경기도 남양주시 별내3로 64-21",
      "mapx": "1271220035",
      "mapy": "376461793"
}
""";

  test('location model convert test', () {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    Location location = Location.fromJson(jsonMap);

    expect(location.title, "별내행정복지센터");
  });
}
