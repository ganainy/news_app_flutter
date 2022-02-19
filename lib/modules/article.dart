import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleScreen extends StatelessWidget {
  final String url;

  const ArticleScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}
