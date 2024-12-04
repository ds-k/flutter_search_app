import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';

class HomeResultView extends ConsumerWidget {
  const HomeResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final locations = state.locations;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: locations == null || locations.isEmpty
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
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(data: locations[index].title, style: {
                            "b": Style(
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
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
                    const SizedBox(
                      height: 15,
                    )
                  ],
                );
              }),
    );
  }
}
