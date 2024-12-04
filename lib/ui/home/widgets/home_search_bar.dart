import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/home/home_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeSearchBar extends StatefulWidget implements PreferredSizeWidget {
  // {PreferredSizeWidget? appBar} appBar의 클래스는 PreferredSizeWidget이기 때문에,
  // HomeSearchBar를 appBar로 사용하려면 PreferredSizeWidget으로 구현(implements)해야함
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final viewModel = ref.watch(homeViewModelProvider.notifier);

      return AppBar(
        title: Container(
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
            controller: textEditingController,
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
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                    onPressed: textEditingController.clear,
                    icon: const Icon(Icons.clear))),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: IconButton(
              icon: const Icon(
                Icons.gps_fixed,
                color: Colors.blue,
              ),
              tooltip: 'Show Snackbar',
              onPressed: () async {
                List addressList =
                    await viewModel.getAddressByLatLngAndSearch();
                if (addressList.isNotEmpty) {
                  textEditingController.text = addressList[0];
                } else {
                  Fluttertoast.showToast(
                      msg: "현재 위치를 찾을 수 없습니다. 다시 시도해주세요.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ),
        ],
      );
    });
  }
}
