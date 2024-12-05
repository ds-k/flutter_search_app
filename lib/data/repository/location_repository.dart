import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_search_app/core/result.dart';
import 'package:flutter_search_app/data/model/location.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LocationRepository {
  // naver 검색 api만 활용하기 때문에, baseUrl과 header option을 baseOptions으로 추가했습니다.
  final Dio _client = Dio(BaseOptions(
    baseUrl: "https://openapi.naver.com/v1/search",
    headers: {
      "X-Naver-Client-Id": dotenv.env['NAVER_CLIENT_ID'] ?? '',
      "X-Naver-Client-Secret": dotenv.env['NAVER_CLIENT_SECRET'] ?? '',
    },
    validateStatus: (status) => true,
  ))
    ..interceptors.add(PrettyDioLogger()); // 응답 상태 확인을 위해 logger를 추가했습니다.

  Future<Result<List<Location>>> search(String query) async {
    final response = await _client.get(
      "/local.json",
      queryParameters: {
        "display": "5",
        "query": query,
      },
    );

    if (response.statusCode == 200) {
      List<Location> data = List.from(response.data["items"])
          .map((item) => Location.fromJson(item))
          .toList(); // Location으로 변환

      return Result.success(data);
    }

    return Result.failure(response.statusCode, response.data["errorMessage"]);
  }
}
