# Flutter Search App

Flutter로 제작된 **지역 검색 애플리케이션**으로, **MVVM 아키텍처**를 기반으로 구현되었습니다. **NAVER 검색 API**, **NAVER 지도 API**, **VWORLD API**, **Geolocator**, **Riverpod**를 활용하여 개발되었습니다.

---

## 전체 시연 GIF
![전체 시연 GIF](https://github.com/user-attachments/assets/1943bff8-a668-4bc0-9d5b-f3ff2b539f9f)

---

## 주요 기능

### 핵심 기능
1. **지역 검색**
   - 지역명을 입력하면 관련된 지역 정보를 리스트로 표시합니다.
   - 각 결과는 다음 정보를 포함합니다:
     - 제목 (Title)
     - 카테고리 (Category)
     - 도로명 주소 (Road Address)
     - 링크 (Link)
     - 위도와 경도 (Lat, Lng)

2. **웹 링크 표시**
   - 결과에 유효한 링크가 있는 경우, 제목 위에 웹 아이콘이 표시됩니다.
   - 아이콘을 클릭하면 WebView를 통해 링크가 열립니다. *(필수 기능 2)*

3. **GPS 기반 검색**
   - GPS 아이콘을 클릭하면 기기의 현재 위치를 가져옵니다.
   - 가져온 위치를 **VWORLD API**로 변환하여 행정구역 정보(읍면동)를 검색에 활용합니다. *(도전 기능 1)*

4. **지도 연동**
   - 각 리스트 항목에는 지도 핀 아이콘이 포함되어 있으며, 클릭 시 해당 위치를 **NAVER 지도**에서 확인할 수 있습니다. *(나만의 기능)*

### 추가 구현 기능
- **환경 변수 관리**:
  - `.env` 파일을 활용해 API 키(Client ID, Client Secret) 등 민감한 정보를 안전하게 관리.
- **로딩 스피너**:
  - 데이터 로딩 중 스피너 애니메이션을 표시.
- **오류 처리**:
  - 오류 발생 시 상태 코드와 에러 메시지를 표시하여 디버깅 용이.
  - ![에러코드 출력](https://github.com/user-attachments/assets/a559a5ec-324c-407f-a4a9-f5fce8bdea38)
- **Toast 알림**:
  - GPS 기반 검색 실패 시 사용자에게 알림 표시.
  - ![토스트 알림](https://github.com/user-attachments/assets/a2996615-b472-42cf-a700-a7d525813291)
- **테스트 케이스 작성**:
  - 모델, 뷰모델, 레포지토리에 대한 테스트 케이스 작성.

---

## 디렉토리 구조

```plaintext
lib
├── core
│   ├── geolocator_helper.dart
│   └── result.dart
├── data
│   ├── model
│   │   └── location.dart
│   └── repository
│       ├── location_repository.dart
│       └── vworld_repository.dart
├── main.dart
└── ui
    ├── detail
    │   └── detail_page.dart
    ├── home
    │   ├── home.dart
    │   ├── home_view_model.dart
    │   └── widgets
    │       ├── home_result_view.dart
    │       └── home_search_bar.dart
    ├── map
    │   └── map_page.dart
    └── widget.dart

pubspec.lock
pubspec.yaml
test
├── home_view_model_test.dart
├── location_model_test.dart
└── location_repository_test.dart
```

---

## 사용 API 및 라이브러리

- **NAVER 검색 API**: 검색어 기반 지역 데이터 검색.
- **NAVER 지도 API**: 지도 화면에서 위치 정보 표시.
- **VWORLD API**: GPS 좌표를 행정구역 주소로 변환.
- **Geolocator**: 기기 위치 데이터 가져오기.
- **Riverpod**: 반응형 상태 관리를 위한 라이브러리.

---

## 트러블슈팅

### 문제와 해결 방법

1. **환경 변수 설정 문제**
   - 문제: `.env` 파일을 인식하지 못함.
   - 해결 방법:
     - `flutter_dotenv` 패키지 설치.
     - `main()` 함수에서 `.env` 파일 로드:
       ```dart
       await dotenv.load(fileName: ".env");
       ```
     - `pubspec.yaml`의 `assets` 섹션에 `.env` 추가.

2. **NAVER 지도 API 통합**
   - 문제: NAVER 검색 API에서 제공하는 `mapx`, `mapy` 필드가 일반적인 위도/경도와 다른 형식.
   - 해결 방법:
     - `mapx`와 `mapy`를 변환해 위도와 경도로 활용 가능함을 확인.
     - `flutter_naver_map` 문서를 참고해 지도에 올바르게 표시.

---

## 테스트

- 주요 컴포넌트에 대한 유닛 테스트 작성:
  - 모델 (예: `Location` 모델)
  - 뷰모델 (예: `HomeViewModel`)
  - 레포지토리 (예: `LocationRepository`)


