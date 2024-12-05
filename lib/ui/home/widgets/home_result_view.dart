import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/detail/detail_page.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';
import 'package:flutter_search_app/ui/map/map_page.dart';

class HomeResultView extends ConsumerWidget {
  const HomeResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final locations = state.locations;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: locations == null
          ? Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text("검색어를 입력해주세요."))
          : locations.isEmpty
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text("검색결과가 없습니다."))
              : ListView.builder(
                  itemCount: locations.length,
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
                                    if (locations[index].link.length >= 5 &&
                                        locations[index]
                                            .link
                                            .startsWith("https")) {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return DetailPage(
                                            title: locations[index].title,
                                            link: locations[index].link,
                                          );
                                        },
                                      ));
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      locations[index].link.length >= 5 &&
                                              locations[index]
                                                  .link
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
                                      Html(
                                          data: locations[index].title,
                                          style: {
                                            "b": Style(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                            "*": Style(
                                                fontSize: FontSize(18),
                                                fontWeight: FontWeight.bold,
                                                margin: Margins.all(0))
                                          }),
                                      Text(locations[index].category),
                                      Text(locations[index].roadAddress),
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
                                        location: locations[index],
                                      );
                                    },
                                  ));
                                },
                                child: const Icon(
                                  Icons.map,
                                  color: Colors.blueAccent,
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
                  }),
    );
  }
}
