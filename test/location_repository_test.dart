import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_search_app/data/model/location.dart';
import 'package:flutter_search_app/data/repository/location_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  final locationRepository = LocationRepository();

  test('locationRepository : 검색 테스트', () async {
    List<Location>? result = await locationRepository.search("별내동");

    expect(result.length, 5);
    expect(result[0].title, "별내행정복지센터");
  });
}
