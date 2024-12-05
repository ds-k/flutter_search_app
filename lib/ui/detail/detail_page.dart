import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.link, required this.title});

  final String title;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Html(
          data: title,
          style: {
            // <b> 태그 일반적인 텍스트로 변환
            "*": Style(
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            )
          },
        ),
        actions: const [
          SizedBox(
              width: kToolbarHeight), // 정렬 맞추기 위해 leading 사이즈와 같은 sizedBox 추가
        ],
      ),
      body: InAppWebView(
        initialSettings: InAppWebViewSettings(
          mediaPlaybackRequiresUserGesture: true,
          javaScriptEnabled: true,
          // userAgent:
          //     "Mozilla/5.0 (Linux; Android 10; Mobile; rv:89.0) Gecko/89.0 Firefox/89.0", // 모바일 페이지로 실행하도록 userAgent 설정
        ),
        initialUrlRequest: URLRequest(
          url: WebUri(link),
        ),
      ),
    );
  }
}
