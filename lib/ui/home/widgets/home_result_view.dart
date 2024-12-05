import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/core/result.dart';
import 'package:flutter_search_app/data/model/location.dart';
import 'package:flutter_search_app/ui/detail/detail_page.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';
import 'package:flutter_search_app/ui/map/map_page.dart';

class HomeResultView extends ConsumerWidget {
  const HomeResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final isLoading = state.isLoading;
    final locations = state.locations;

    Widget currentWidget(bool isLoading, dynamic locations) {
      // 상태 판단 후 해당 상태에 맞는 위젯 반환
      switch (true) {
        case true when isLoading:
          return loadingContainer();

        case true when locations == null:
          // 로딩 중이 아닌데 locations가 null이면 초기 상태
          return initialContainer();

        case true when locations.isSuccess && locations.data!.isEmpty:
          // 응답 성공했으나 데이터가 없는 경우
          return noResultsContainer();

        case true when locations.isSuccess && locations.data!.isNotEmpty:
          // 응답 성공하고 데이터가 있는 경우
          return searchResultsListView(locations);

        default:
          // 그 외의 경우는 오류 상태
          return errorDisplayContainer(locations);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: currentWidget(isLoading, locations),
    );
  }

  Container errorDisplayContainer(Result<List<Location>> locations) {
    return Container(
        // 응답이 실패했을때
        width: double.infinity,
        alignment: Alignment.center,
        child: Text("${locations.errorCode} : ${locations.errorMessage}"));
  }

  ListView searchResultsListView(Result<List<Location>> locations) {
    return ListView.builder(
        itemCount: locations.data!.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (locations.data![index].link.length >= 5 &&
                              locations.data![index].link.startsWith("https")) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(
                                  title: locations.data![index].title,
                                  link: locations.data![index].link,
                                );
                              },
                            ));
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            locations.data![index].link.length >= 5 &&
                                    locations.data![index].link
                                        .startsWith("https")
                                // http는 접속 안되도록 했습니다.
                                ? const Column(
                                    children: [
                                      Icon(
                                        Icons.language,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      )
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            Html(data: locations.data![index].title, style: {
                              "b": Style(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              "*": Style(
                                  fontSize: FontSize(18),
                                  fontWeight: FontWeight.bold,
                                  margin: Margins.all(0))
                            }),
                            Text(locations.data![index].category),
                            Text(locations.data![index].roadAddress),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return MapPage(
                              location: locations.data![index],
                            );
                          },
                        ));
                      },
                      child: const Icon(
                        Icons.place,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          );
        });
  }

  Container noResultsContainer() {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: const Text("검색결과가 없습니다."));
  }

  Container initialContainer() {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: const Text("검색어를 입력해주세요."));
  }

  Container loadingContainer() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}
