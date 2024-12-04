import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final viewModel = ref.watch(homeViewModelProvider.notifier);

      return Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
            ),
          ],
        ),
        child: TextField(
          // ! 너무 빈번한 호출이 발생해서 일단은 주석처리했습니다.
          // onChanged: (text) {
          //   if (RegExp(r'^[가-힣0-9a-zA-Z]+$').hasMatch(text)) {
          //     // 검색어가 완성형 문자일때만 실행되도록
          //     viewModel.search(text);
          //   }
          // },
          onSubmitted: (text) {
            viewModel.search(text);
          },
          decoration: InputDecoration(
            hintText: "검색어를 입력해주세요.",
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      );
    });
  }
}
