import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_search_app/data/model/location.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.location});
  final Location location;

  @override
  Widget build(BuildContext context) {
    double lat = double.parse(location.mapy.replaceRange(2, 2, '.'));
    double lng = double.parse(location.mapx.replaceRange(3, 3, '.'));

    return Scaffold(
        appBar: AppBar(
          title: const Text("지도 보기"),
        ),
        body: NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
                target: NLatLng(lat, lng), zoom: 15, bearing: 0, tilt: 0),
          ),
          onMapReady: (controller) {
            final marker = NMarker(id: "1", position: NLatLng(lat, lng));
            controller.addOverlay(marker);
          },
        ),
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Column(
              children: [
                Html(
                  data: location.title,
                  style: {
                    // <b> 태그 일반적인 텍스트로 변환
                    "*": Style(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSize(20),
                      textAlign: TextAlign.center,
                    )
                  },
                ),
                Text(location.category),
                Text(location.address),
              ],
            ),
          ),
        ));
  }
}
