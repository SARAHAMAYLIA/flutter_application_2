import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBar(
        title: Text("Kampus Website"),
      ),
      body: WebView(
        initialUrl: "https://kampusmu.ac.id", // ganti dengan URL kampusmu
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
