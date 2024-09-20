import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ipotec/utilities/common/core_app_bar.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? currentUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        currentUrl = widget.url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: CoreAppBar(
          showBackButton: true,
          showActions: false,
          title: widget.title,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(currentUrl ?? widget.url)),
          onWebViewCreated: (InAppWebViewController controller) {},
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              javaScriptEnabled: true,
              supportZoom: false,
              allowFileAccessFromFileURLs: false,
            ),
          ),
          onLoadStart: (controller, url) async {
            debugPrint("onLoadStart:::::::::$url");
            if (url.toString() != widget.url) {
              Navigator.pop(context);
            }
          },
          onLoadError: (controller, url, code, message) async {
            debugPrint("onLoadError:::::::::$url");
          },
          onLoadStop: (controller, url) async {
            debugPrint("onLoadStop:::::::::$url");
          },
          onProgressChanged: (controller, progress) async {
            debugPrint("onProgressChanged:::::::::$progress");
          },
        ),
      ),
    );
  }
}
