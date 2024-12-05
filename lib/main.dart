import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_app/ui/home/home.dart';

void main() async {
  // * 연습 목적으로 env를 추가했습니다. 과제 제출이기 때문에 .gitignore에 .env를 추가하지 않았습니다.
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance
      .initialize(clientId: dotenv.env['NAVER_MAP_CLIENT_ID'] ?? '');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white)),
      home: const Home(),
    );
  }
}
