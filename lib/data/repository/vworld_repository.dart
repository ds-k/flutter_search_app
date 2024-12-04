import "package:dio/dio.dart";
import "package:pretty_dio_logger/pretty_dio_logger.dart";

class VworldRepository {
  final Dio _client = Dio(BaseOptions(
    baseUrl: "https://api.vworld.kr/req/data",
    validateStatus: (status) => true,
  ))
    ..interceptors.add(PrettyDioLogger()); // 응답 상태 확인을 위해 logger를 추가했습니다.

  Future<List<String>> findByLatLng({
    required double lat,
    required double lng,
  }) async {
    final response = await _client.get(
      "",
      queryParameters: {
        "request": "GetFeature",
        "data": "LT_C_ADEMD_INFO",
        "key": "EE74F8DA-20FF-39BE-9348-496808D0E75D",
        "geomfilter": "point($lng $lat)",
        "geometry": "false",
        "size": 100,
      },
    );

    if (response.statusCode == 200 &&
        response.data["response"]["status"] == "OK") {
      return List.of(response.data["response"]["result"]["featureCollection"]
              ["features"])
          .map((e) => e["properties"]["full_nm"].toString())
          .toList();
    }

    return [];
  }
}
