import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/core/geolocator_helper.dart';
import 'package:flutter_search_app/data/model/location.dart';
import 'package:flutter_search_app/data/repository/location_repository.dart';
import 'package:flutter_search_app/data/repository/vworld_repository.dart';

class HomeState {
  HomeState({required this.locations, this.isLoading = false});

  List<Location>? locations;
  bool isLoading;
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(locations: null, isLoading: false);
  }

  Future<void> search(String query) async {
    LocationRepository locationRepository = LocationRepository();

    state = HomeState(locations: null, isLoading: true);
    state = HomeState(
        locations: await locationRepository.search(query), isLoading: false);
  }

  Future<List> getAddressByLatLngAndSearch() async {
    // geoLocator로 위도, 경도 가져오기
    final position = await GeolocatorHelper.getPositon();
    dynamic address;
    if (position != null) {
      // vWorld API로 주소 가져오기
      VworldRepository vworldRepository = VworldRepository();

      address = await vworldRepository.findByLatLng(
          lat: position.latitude, lng: position.longitude);
    }

    // Naver API에 받아온 주소를 보내 검색한 후 상태 업데이트
    LocationRepository locationRepository = LocationRepository();

    state = HomeState(locations: null, isLoading: true);

    if (address.isNotEmpty) {
      state = HomeState(
          locations: await locationRepository.search(address[0]),
          isLoading: false);
    }
    // 검색창 업데이트를 추가하기 위해 주소값을 리턴해주었습니다.
    // 빈 배열 리턴 여부로 현재 위치를 못찾는 상황 분기하기 위해 address[0]이 아닌 address를 리턴했습니다.
    return address;
  }
}

final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
