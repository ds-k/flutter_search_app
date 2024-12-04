import 'package:flutter/material.dart';
import 'package:flutter_search_app/ui/home/widgets/home_result_view.dart';
import 'package:flutter_search_app/ui/home/widgets/home_search_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const HomeSearchBar()),
        body: const HomeResultView(),
      ),
    );
  }
}
